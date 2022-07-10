#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "blockchain-dashboard-url" {
  value       = ibm_resource_instance.blockchain.dashboard_url
  description = "blockchain Service Dashboard URL"
  sensitive   = false
}