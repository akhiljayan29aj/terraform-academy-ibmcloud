#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
resource "ibm_resource_instance" "iotf-service" {
  name              = var.iot_name
  service           = "iotf-service"
  plan              = var.iot_plan
  location          = var.location
  resource_group_id = var.course_rg_id
}
