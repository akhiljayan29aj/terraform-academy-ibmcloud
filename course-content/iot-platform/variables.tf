#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# Resource Group 
variable "course_rg_id" {
  description = "Resource Groupe ID"
  type        = string
}

# Region / Location
variable "location" {
  description = "Provisioning Region/Location for the instance"
  type        = string
  default     = "us-south"
}


# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
variable "iot_name" {
  description = "Blockchain Platform service instance name"
  type        = string
  default     = "tf-academy-training-iot-service"
}

variable "iot_plan" {
  description = "IOT Platform service Plan"
  type        = string
  default     = "iotf-service-free"
}
