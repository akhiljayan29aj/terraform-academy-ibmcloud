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


variable "cos_name" {
  description = "COS instance name"
  type        = string
  default     = "tf-academy-training-cos-service"
}

variable "cos_plan" {
  description = "COS Bucket Plan"
  type        = string
  default     = "lite"
}
