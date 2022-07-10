# Example of Terraform IBM Cloud Academy Training

This Terraform automation illustrates how to setup the cloud resources for training purpose and that can be decommission after `X mnts / Hrs` using IBM Cloud Schematics. Auto decommission of PaaS services driven via Cloud functions.

![plot](./images/schematics_governance.png?raw=true])

## Use cases

### 'Course Admin' usecases
* Use the course admin's account, to provision the IBM Cloud services (as per the course content), in each Student account, 'course_content' resource group.
* Use the course admin's account, to automatically destroy the course_content_resources; after 6 hours.
* Use the course admin's account, to manually destroy & provision the course_content_resources.

### 'Students' usecases
* Work with the course-content (Virtual server for VPC, watson-studio, machine-learning, etc..) provisioned in the 'course_content' resource group.
* Will not be able to administer (create, delete, ..) the course-content resources.

## Instructions

1. Login into Enterprise account. 
2. Make sure that you are [assigned the correct permissions](https://cloud.ibm.com/docs/schematics?topic=schematics-access) to create workspaces and deploy resources.
3. Create the Schematics governance workspace:
    1. From the IBM Cloud menu select [Schematics](https://cloud.ibm.com/schematics/overview).
       - Click **Create workspace**.   
       - Enter a name for your workspace.   
       - Click **Create** to create your workspace.
    2. On the workspace **Settings** page, enter this URL - https://github.com/Cloud-Schematics/terraform-academy-ibmcloud/tree/dev
     - Select the Terraform version: Terraform 1.0 or higher
     - Click **Save template information**.
     - In the **Input variables** section,  The only one required parameter is:
         - ibmcloud_api_key of the student IBM Cloud acccount
      - Click **Save changes**.
      - The student account governance workspace is completed.
4.  Now apply your Terraform template by clicking **Apply plan**.
5.  As part of this Apply action, the PaaS services that are required for the student training will be provisioned in given students account.
6.  Also Cloud function will be created in the owner's enterprise account which will monitor the student's account resources. This cloud function cron-job will de-provision student account resources after the `X mins`.

## Note

* When you provision `Virtual server for VPC`, By default it allocates only 10 VPC per region.
* If `Apply Plan` fails on student workspace, Governance workspace will continue to configure the decommission timer on failed workspace.
  Governance workspace will report the `Apply Plan` failure as warning & ask admin to check workspace apply logs for more details on failure.
   

## Compatibility

This module is meant for use with Terraform 0.13 or later.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13 or later.
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Install

### IBM Cloud CLI

Be sure you have installed IBM Cloud plug-in for Satellite
- https://cloud.ibm.com/docs/satellite?topic=satellite-setup-cli

### Terraform

Be sure you have the correct Terraform version ( 0.13 or later), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform provider plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Usage

```
terraform init
```
```
terraform plan
```
```
terraform apply
```
```
terraform destroy
```

## Example Usage

``` hcl
module "course_governance" {
  source = "./course-governance"

  ibmcloud_api_key  = var.ibmcloud_api_key
  user_list  = var.user_list
  decomission_timer = var.decomission_timer
  course_prefix     = var.course_prefix
  create_bc         = var.create_bc
  bch_plan          = var.bch_plan
  create_iot        = var.create_iot
  iot_plan          = var.iot_plan
  create_ml         = var.create_ml
  ml_plan           = var.ml_plan
  create_ws         = var.create_ws
  ws_plan           = var.ws_plan
  create_vsi        = var.create_vsi
  image             = var.image
  profile           = var.profile
}
```

## Inputs

| name | description | type | required | default | sensitive |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | -------------- | ---------- | ------------------------------------ | ---- |
|  ibmcloud_api_key | Provide student's IBM Cloud APIKEY [Refer IBM Cloud Docs](https://cloud.ibm.com/docs/account?topic=account-userapikey&interface=ui)  |  string |  ✓   |       | ✓ |
|  decomission_timer | Time length to de-provision the resource after the creation. | string  |  NA |   10m   | ---- |
|  course_prefix | Prefix to the Names of all Cloud Resources. | string  |  NA |   tf-acacdemy-training   | ---- |
|  user_list | Student Information. | list(object)  |  NA | [{ name   = "user-1" email  = "user1@domain.com" apikey = "apikey-1" },] | ---- |
|  create_bc | If set to true, it will create block chain. | bool  |  NA |   false   | ---- |
|  bch_plan | Blockchain Platform service Plan. | string  |  NA |   standard   | ---- |
|  create_iot | If set to true, it will create iot. | bool  |  NA |   false   | ---- |
|  iot_plan | IOT Platform service Plan. | string  | NA  |   iotf-service-free   | ---- |
|  create_ml | If set to true, it will create machine learning. | bool  |  NA |   false   | ---- |
|  ml_plan | Machine learning service Plan. | string  |  NA |   lite   | ---- |
|  create_ws | If set to true, it will create watson professional. | bool  |  NA |   true   | ---- |
|  ws_plan | Watson Studio service instance Plan. | string  | NA  |   professional-v1   | ---- |
|  create_vsi | If set to true, it will create Virtual server for VPC. | bool  |  NA |   false   | ---- |


## Outputs

|  **Name**                  | **Description**                                    |
|  --------------------------| ---------------------------------------------------|
|  workspace_id              | Schematics worksapce Id                            |
|  job_id                    | Schematics workspace apply job Id                  |
|  job_created_timer         | Schematics workspace resource created time         |
|  job_decomission_timer     | schematics workspace resource de-provision time    |
|  cron_expr                 | Cron expression for cloud function to trigger alarm (UTC timezone) |
