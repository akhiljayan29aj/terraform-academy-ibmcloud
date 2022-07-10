
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

# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
variable "bch_name" {
  description = "Blockchain Platform service instance name"
  type        = string
  default     = "tf-academy-training-blockchain-service"
}

variable "bch_plan" {
  description = "Blockchain Platform service Plan"
  type        = string
  default     = "standard"
}
