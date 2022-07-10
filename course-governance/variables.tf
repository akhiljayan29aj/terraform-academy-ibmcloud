#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

##########################################################
# IBM Authentication Variables
##########################################################

variable "ibmcloud_api_key" {
  description = "IBM Cloud API key"
  type        = string
}

variable "course_prefix" {
  description = "Resource Group ID used for Training"
  type        = string
  default     = "tf-acacdemy-training"
}

##########################################################
# IBM Cloud Schematics Variables
##########################################################

variable "schematics_workspace_location" {
  description = "The location where you want to create your Schematics workspace and run Schematics actions. The location that you enter must match the API endpoint that you use. For example, if you use the Frankfurt API endpoint, you must specify `eu-de` as your location. If you use an API endpoint for a geography and you do not specify a location, Schematics determines the location based on availability."
  type        = string
  default     = "us-east"
}

variable "schematics_workspace_name" {
  description = "The name of your workspace. The name can be up to 128 characters long and can include alphanumeric characters, spaces, dashes, and underscores. When you create a workspace for your own Terraform template, consider including the microservice component that you set up with your Terraform template and the IBM Cloud environment where you want to deploy your resources in your name."
  type        = string
  default     = "academy-trainingworkspace"
}

variable "schematics_workspace_template_repo" {
  description = "Template repo to provision the cloud resource."
  type        = string
  default     = "https://github.com/anilkumarnagaraj/terraform-academy-ibmcloud/tree/multi_user_account/course-content"
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
}

##########################################################
# IBM Cloud Functions Variables
##########################################################

variable "namespace" {
  description = "The name IAM based cloud function namespace."
  type        = string
  default     = "academy-trainingnamespace"
}

variable "action_name" {
  description = "Action name."
  type        = string
  default     = "schematics-cron"
}

variable "apply_action_name" {
  description = "Action name."
  type        = string
  default     = "schematics-apply"
}

variable "trigger_name" {
  description = "Trigger name."
  type        = string
  default     = "schematics-trigger"
}

variable "rule_name" {
  description = "Rule name."
  type        = string
  default     = "schematics-rule"
}

variable "decomission_timer" {
  description = "Time length to de-provision the resource after the creation.."
  type        = string
  default     = "4m"
}

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

variable "create_ml" {
  description = "If set to true, it will create machine learning"
  type        = bool
  default     = false
}

variable "ml_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "lite" # Other supported plans 'v2-standard/v2-professional'.
}

variable "create_ws" {
  description = "If set to true, it will create watson"
  type        = bool
  default     = false
}

variable "ws_plan" {
  description = "Watson Studio service instance Plan"
  type        = string
  default     = "professional-v1" # Other supported plan 'free-v1'.
}

#####################################################
# VPC Parameters
#####################################################

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
  default     = "bx2-2x8"
}
