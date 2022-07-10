#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# Resource Group 
variable "course_rg_id" {
  description = "Resource Groupe ID"
  type        = string
}

variable "location" {
  description = "Provisioning Region/Location for the instance"
  type        = string
  default     = "us-south"
}

# Watson Studio - https://cloud.ibm.com/catalog/services/watson-studio
variable "ws_name" {
  description = "Watson Studio service instance name"
  type        = string
  default     = "VIT-watson-studio-service"
}

variable "ws_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "professional-v1" # Other supported plan 'free-v1'.
}
