#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# IBM Cloud autheticate variables

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

variable "course_prefix" {
  description = "Prefix to the Names of all Cloud Resources"
  type        = string
  default     = "tf-acacdemy-training"
}

variable "user_list" {
  type = list(object({
    name   = string
    email  = string
    apikey = string
  }))

  default = [
    {
      name   = "user-1"
      email  = "user1@domain.com"
      apikey = "apikey-1"
    },
  ]

  validation {
    condition     = length(var.user_list) <= 30
    error_message = "Automation supports ony 30 users for provisioning."
  }
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation."
  type        = string
  default     = "10m"
}

# Blockchain

variable "create_bc" {
  description = "If set to true, it will create block chain"
  type        = bool
  default     = false
}

variable "bch_plan" {
  description = "Blockchain Platform service Plan"
  type        = string
  default     = "standard"
}

# IOT

variable "create_iot" {
  description = "If set to true, it will create iot"
  type        = bool
  default     = false
}

variable "iot_plan" {
  description = "IOT Platform service Plan"
  type        = string
  default     = "iotf-service-free"
}

# Machine Learning

variable "create_ml" {
  description = "If set to true, it will create machine learning"
  type        = bool
  default     = false
}

variable "ml_plan" {
  description = "Machine learning service instance Plan"
  type        = string
  default     = "lite" # Other supported plans 'v2-standard/v2-professional'.
}

# Watson

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
  default     = true
}

variable "ws_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "professional-v1" # Other supported plan 'free-v1'.
}

# Virtual Server for VPC

variable "create_vsi" {
  description = "If set to true, it will create VSI"
  type        = bool
  default     = false
}

variable "image" {
  description = "Image ID for the instance"
  type        = string
  default     = "ibm-redhat-7-9-minimal-amd64-3"
}

variable "profile" {
  description = "Profile type for the Instance"
  type        = string
  default     = "gx2-16x128x1v100"
}
