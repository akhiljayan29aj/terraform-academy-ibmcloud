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

# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning
variable "ml_name" {
  description = "Machine Learning service instance name"
  type        = string
  default     = "tf-academy-training-ml-service"
}

variable "ml_plan" {
  description = "Machine learning service instance Plan"
  type        = string
  default     = "lite" # Other supported plans 'v2-standard/v2-professional'.
}
