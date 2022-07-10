#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "resource_group_id" {
  value       = var.course_resource_group_id
  description = "Resource Group ID"
  sensitive   = false
}