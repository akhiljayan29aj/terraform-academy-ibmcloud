#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "resource_group_id" {
  value       = ibm_resource_group.rg.id
  description = "Resource Group ID"
  sensitive   = false
}

output "resource_group_name" {
  value       = ibm_resource_group.rg.name
  description = "Resource Group Name"
  sensitive   = false
}
