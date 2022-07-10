#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

variable "course_resource_group_id" {
  type        = string
  description = "Resource Group ID used for Training"
}

variable "accgrp_name" {
  type        = string
  description = "Name of the Access Group used for Training"
  default     = "tf-academy-training-AG"
}

variable "user_list" {
  type        = list(string)
  description = "Name of the Access Group used for Training in comma (,) seperated values"
}

# Blockchain

variable "create_bc" {
  description = "If set to true, it will create block chain"
  type        = bool
  default     = false
}

# IOT

variable "create_iot" {
  description = "If set to true, it will create iot"
  type        = bool
  default     = false
}

# Machine Learning

variable "create_ml" {
  description = "If set to true, it will create machine learning"
  type        = bool
  default     = false
}

# Blockchain

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
  default     = false
}

# Virtual Server for VPC

variable "create_vsi" {
  description = "If set to true, it will create VSI"
  type        = bool
  default     = false
}