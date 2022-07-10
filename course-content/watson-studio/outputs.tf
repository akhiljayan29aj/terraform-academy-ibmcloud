#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "watson-studio-dashboard-url" {
  value       = ibm_resource_instance.data-science-experience.dashboard_url
  description = "Watson Studio Dashboard URL"
  sensitive   = false
}