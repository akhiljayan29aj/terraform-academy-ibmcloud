#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

locals {
  workspace_batch_list = chunklist(var.user_list, 6)

  workspace_ids = merge(
    { for k, workspace in ibm_schematics_workspace.schematics_workspace_instance_1 : workspace.id => workspace.name },
    { for k, workspace in ibm_schematics_workspace.schematics_workspace_instance_2 : workspace.id => workspace.name },
    { for k, workspace in ibm_schematics_workspace.schematics_workspace_instance_3 : workspace.id => workspace.name },
    { for k, workspace in ibm_schematics_workspace.schematics_workspace_instance_4 : workspace.id => workspace.name },
    { for k, workspace in ibm_schematics_workspace.schematics_workspace_instance_5 : workspace.id => workspace.name },
  )

  workspace_decommission_list = [
    for idx, prop in var.user_list :
    {
      prop = {
        "index"                 = idx
        "workspace_id"          = jsondecode(data.local_file.read_job[idx].content).command_object_id
        "end_at"                = jsondecode(data.local_file.read_job[idx].content).end_at
        "job_destroy_timestamp" = timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).end_at), var.decomission_timer)
        "cron_expr"             = format("%s %s %s * *", substr(timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).end_at), var.decomission_timer), 14, 2), substr(timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).end_at), var.decomission_timer), 11, 2), substr(timeadd(formatdate("YYYY-MM-DD'T'hh:mm:ssZ", jsondecode(data.local_file.read_job[idx].content).end_at), var.decomission_timer), 8, 2))
      }
    }
  ]

}