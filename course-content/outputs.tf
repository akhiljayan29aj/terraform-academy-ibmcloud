#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "blockchain-dashboard-url" {
  value       = var.create_bc ? concat(module.blockchain.*.blockchain-dashboard-url, [""])[0] : ""
  description = "blockchain Service Dashboard URL"
  sensitive   = false
}


output "iot-service-dashboard-url" {
  value       = var.create_iot ? concat(module.iot.*.iot-service-dashboard-url, [""])[0] : ""
  description = "IOT Service Dashboard URL"
  sensitive   = false
}

output "machine-learning-dashboard-url" {
  value       = var.create_ml ? concat(module.ml.*.machine-learning-dashboard-url, [""])[0] : ""
  description = "Machine Learning Service Dashboard URL"
  sensitive   = false
}

output "watson-studio-dashboard-url" {
  value       = var.create_ws ? concat(module.watson-studio.*.watson-studio-dashboard-url, [""])[0] : ""
  description = "Watson Studio Dashboard URL"
  sensitive   = false
}

output "vpc_id" {
  description = "The ID of the vpc"
  value       = var.create_vsi ? concat(module.vpc.vpc_id, [""])[0] : ""
}

output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = var.create_vsi ? module.vpc.subnet_ids : []
}
