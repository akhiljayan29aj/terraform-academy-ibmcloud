#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

output "iot-service-dashboard-url" {
  value       = ibm_resource_instance.iotf-service.dashboard_url
  description = "IOT Service Dashboard URL"
  sensitive   = false
}

