#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

# Resource Group 
variable "course_resource_group_id" {
  description = "Resource Group ID used for Training"
  type        = string
}

# Course Prefix for Resource name
variable "course_prefix" {
  description = "Resource Group ID used for Training"
  type        = string
  default     = "tf-acacdemy-training"
}

variable "accgrp_name" {
  type        = string
  description = "Name of the Access Group used for Training"
  default     = "tf-academy-training-AG"
}

variable "user_list" {
  type        = list(string)
  description = "Name of the Access Group used for Training in comma (,) seperated values"
  default     = []
}

# Common
variable "location" {
  description = "Provisioning Region/Location for the instance"
  type        = string
  default     = "us-south"
}

variable "create_bc" {
  description = "If set to true, it will create block chain"
  type        = bool
  default     = false
}

variable "create_iot" {
  description = "If set to true, it will create iot"
  type        = bool
  default     = false
}

variable "create_ml" {
  description = "If set to true, it will create machine learning"
  type        = bool
  default     = false
}

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
  default     = false
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

# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning
variable "ml_name" {
  description = "Machine Learning service instance name"
  type        = string
  default     = "VIT-machine-learning-service"
}

variable "ml_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "lite" # Other supported plans 'v2-standard/v2-professional'.
}

# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
variable "bch_name" {
  description = "Blockchain Platform service instance name"
  type        = string
  default     = "VIT-blockchain-service"
}

variable "bch_plan" {
  description = "Blockchain Platform service Plan"
  type        = string
  default     = "standard"
}

# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
variable "iot_name" {
  description = "Blockchain Platform service instance name"
  type        = string
  default     = "VIT-iot-service"
}

variable "iot_plan" {
  description = "IOT Platform service Plan"
  type        = string
  default     = "iotf-service-free"
}

#####################################################
# VPC Parameters
#####################################################

variable "create_vsi" {
  description = "True to create new VSI for VPC. False if VPC is already existing and subnets or address prefixies are to be added"
  type        = bool
  default     = "false"
}

variable "vpc_name" {
  description = "Name of the vpc"
  type        = string
  default     = "tf-academy-training-vpc"
}

variable "image" {
  description = "Image ID for the instance"
  type        = string
  default     = "ibm-redhat-7-9-minimal-amd64-3"
}

variable "profile" {
  description = "Profile type for the Instance"
  type        = string
  default     = "bx2-2x8"
}