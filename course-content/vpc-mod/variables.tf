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

variable "course_prefix" {
  description = "Resource Group ID used for Training"
  type        = string
  default     = "tf-acacdemy-training"
}


variable "course_resource_group_id" {
  description = "Resource Group ID used for Training"
  type        = string
}

variable "location" {
  description = "Provisioning Region/Location for the instance"
  type        = string
  default     = "us-south"
}
