import requests
import json
import os
import time
import argparse
import multiprocessing
import base64


TOKEN_URL = "https://iam.cloud.ibm.com/identity/token"
SCHEMATCIS_API = "https://us.schematics.cloud.ibm.com"
ERR_STATUS_CODE = [400, 401, 404, 403, 409, 500, 502]
NONE_TYPE = type(None)

def get_tokens(apikey, add_user=True):
    refresh_token = ""
    access_token = ""
    # get access token form api-key
    if add_user:
        response = requests.post(TOKEN_URL, data={'grant_type': 'urn:ibm:params:oauth:grant-type:apikey', 'apikey': apikey}, auth=('bx', 'bx'))
    else:
        response = requests.post(TOKEN_URL, data={'grant_type': 'urn:ibm:params:oauth:grant-type:apikey', 'apikey': apikey})
    if response.status_code not in ERR_STATUS_CODE:
        #data = json.loads(response.json())
        data = response.json()
        refresh_token = data['refresh_token']
        access_token = 'Bearer ' + data['access_token']
    return access_token, refresh_token

def get_worksapce_info(access_token, workspace_id):
    while True:
        try:
            schematics_headers = {
                'Authorization' : access_token,
                'Accept': 'application/json'
            }
            response = requests.get(SCHEMATCIS_API+'/v1/workspaces/{}'.format(workspace_id), headers=schematics_headers)
            if response.status_code not in ERR_STATUS_CODE:
                return response.json()
            else:
                time.sleep(30) 
        except (requests.exceptions.ConnectionError, json.decoder.JSONDecodeError):
            # To avoid resource controller rate limiting error adding 30 secs sleep timer
            time.sleep(30)    
    
def apply_plan(ws_id, access_token, refresh_token):
    while True:
        try:
            schematics_headers = {
                'Authorization' : access_token,
                'refresh_token' : refresh_token,
                'Accept': 'application/json'
            }
            response = requests.put(SCHEMATCIS_API+'/v1/workspaces/{}/apply'.format(ws_id), headers=schematics_headers)
            if response.status_code not in ERR_STATUS_CODE:
                data = response.json()
                return data
            else:
                time.sleep(30)
        except (requests.exceptions.ConnectionError, json.decoder.JSONDecodeError):
            # To avoid resource controller rate limiting error adding 30 secs sleep timer
            time.sleep(30)
          
def get_job_info(access_token, job_id):
    while True:
        try:
            schematics_headers = {
                'Authorization' : access_token,
                'Accept': 'application/json'
            }
            response = requests.get(SCHEMATCIS_API+'/v2/jobs/{}'.format(job_id), headers=schematics_headers)
            if response.status_code not in ERR_STATUS_CODE:
                data = response.json()
                return data
            else:
                time.sleep(30)
        except (requests.exceptions.ConnectionError, json.decoder.JSONDecodeError):
             # To avoid resource controller rate limiting error adding 30 secs sleep timer
            time.sleep(30) 
   
def convert_dict_to_json(data):
    # Convert dict to str
    json_str = json.dumps(data, indent = 4) 
    # Convert string to json object
    json_object = json.loads(json_str)
    
    return json_object

def base64_decode_message(base64_message):
    base64_bytes = base64_message.encode('ascii')
    message_bytes = base64.b64decode(base64_bytes)
    message = message_bytes.decode('ascii')
    
    return message  

def notify_slack_channel(access_token, slack_message):
    # Secrets Manager instance created in POC account with kv secret created for storing the slack webhook url
    SM_SERVICE_URL = "https://d6821ca2-34fb-41de-baae-960ac8bab35b.us-east.secrets-manager.appdomain.cloud"
    KV_SECRET_ID = 'ef218084-7c4e-7443-1079-f614d9828719'

    sm_headers = { 'Content-Type': 'application/json', 'Authorization': access_token }
    sm_url = SM_SERVICE_URL+'/api/v1/secrets/kv/{}'.format(KV_SECRET_ID)
    sm_response = requests.get(sm_url, headers=sm_headers)
    print("Status Code for SM : ", sm_response.status_code)
    if sm_response.status_code not in ERR_STATUS_CODE:
        data = sm_response.json()
        json_object = convert_dict_to_json(data)
        if type(json_object) != NONE_TYPE:
            slack_webhook_url = json_object['resources'][0]['secret_data']['payload']['slack_webhook_url']
            slack_headers = { 'Content-Type': 'application/json'}
            slack_data = {"text" : slack_message}
            slack_response = requests.post(slack_webhook_url, headers=slack_headers, json=slack_data)
            print("Posted a message to Slack Webhook URL. Response Status Code is: ", slack_response.status_code)
        else:
            print("Secrets Manager failed to get secret for kv "+ KV_SECRET_ID +".")


def task(access_token, refresh_token, workspace_id, workspace_name, job_index, apikey):
    job_file = "/tmp/.schematics/job_info_" + str(job_index) + ".json"
    # Get schematics workspace details
    while True:
        ws_info = get_worksapce_info(access_token, workspace_id)
        if type(ws_info) != NONE_TYPE and 'status' in ws_info:
            # Check workspace is already in active state  
            if ws_info['status'] == "ACTIVE" and ws_info["last_action_name"] == "APPLY" and ws_info["last_activity_id"] != "":
                job_data = get_job_info(access_token, ws_info["last_activity_id"])
                if type(job_data) != NONE_TYPE:
                        with open(job_file, "w") as out_file:
                            json.dump(job_data, out_file)
                        return {"info" : "Schematics apply plan completed successfully."}    
            if ws_info['status'] == "INACTIVE" or ws_info['status'] == "ACTIVE" or ws_info['status'] == "FAILED":
                break
        time.sleep(5)

    # Apply plan on schematics workspace
    data = apply_plan(workspace_id, access_token, refresh_token)
    json_object = convert_dict_to_json(data)
    if type(json_object) != NONE_TYPE:
        job_id = json_object["activityid"]
    else:
        print("Schematics apply plan failed to get response for job in workspace "+ workspace_name +".")
        exit(1)
    
    # Wait for apply plan to start processing
    time.sleep(30)

    # Get apply plan status
    status = "provisioning"
    while status != "job_finished" or status != "job_failed":
        # Get apply plan status
        job_data = get_job_info(access_token, job_id)
        if type(job_data) != NONE_TYPE:
            json_object = convert_dict_to_json(job_data)
            if type(json_object) != NONE_TYPE and 'status' in json_object:
                status = json_object["status"]["workspace_job_status"]["status_code"]
                if status == "job_finished":  
                    with open(job_file, "w") as outfile:
                        json.dump(job_data, outfile)
                    # send notification to slack channel
                    slack_message = "Schematics apply plan completed successfully for workspace --> " + workspace_name
                    notify_slack_channel(access_token, slack_message)
                    return {"info" : "Schematics apply plan completed successfully."}
                elif status == "job_failed":
                    print("Schematics Apply Plan Failed on workspace " + workspace_name +". Check workspace apply logs for more details on failure.")
                    with open(job_file, "w") as outfile:
                        json.dump(job_data, outfile)
                    # send notification to slack channel
                    slack_message = "Schematics apply plan failed for workspace --> " + workspace_name
                    notify_slack_channel(access_token, slack_message)
                    return {"error" : "Schematics Apply Plan Failed on workspace " + workspace_name + "."}     
                        
def main():
    start_time = time.perf_counter()
    processes = []

    # Parse arguments from command line
    parser = argparse.ArgumentParser()
    # Set up required arguments this script
    parser.add_argument('workspace_ids', type=str, help='workspace_ids')
    parser.add_argument('user_list', type=str, help='user_list')
    
    # Parse the given arguments
    args = parser.parse_args()
    workspace_obj = json.loads(base64_decode_message(args.workspace_ids))
    user_list = json.loads(base64_decode_message(args.user_list))

    if not os.path.exists('/tmp/.schematics'):
        os.makedirs('/tmp/.schematics', exist_ok=True)

    i = 0
    for workspace_id in workspace_obj:
        workspace_name = workspace_obj[workspace_id]
        apikey = user_list[i]["apikey"]
        if  apikey == "" or workspace_id == "":
            print('No apikey or worspaces_id is provided!')
            exit(1)

        access_token, refresh_token = get_tokens(apikey)
        if refresh_token == "" or access_token == "":
            print("Failed to fetch refresh and access tokens for workspace '"+ workspace_name+ "'.") 
            exit(1)
            

        time.sleep(2)
        p = multiprocessing.Process(target = task, args=(access_token, refresh_token, workspace_id, workspace_name, i))
        p.start()
        processes.append(p)
        i+=1

    # Joins all the processes 
    for p in processes:
        print()
        p.join()

    # Check json files created for all workspaces
    i = 0
    for workspace_id in workspace_obj:
        file_name = "/tmp/.schematics/job_info_" + str(i) + ".json"
        if os.path.exists(file_name) == False:
            print("Schematics Apply Plan not able to create job status file in workspace '" + workspace_obj[workspace_id] +"'. Verify the students workspace logs for any failure or re-run the governance workspace again.") 
            exit(1)
        i+=1    

    finish_time = time.perf_counter()
    print(f"Program finished in {finish_time-start_time} seconds.")  

if __name__ == '__main__':
    main()

