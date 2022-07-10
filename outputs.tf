#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "workspace_decommission_list" {
  description = "Workspace information"
  value       = module.course_governance.*.workspace_decommission_list
}