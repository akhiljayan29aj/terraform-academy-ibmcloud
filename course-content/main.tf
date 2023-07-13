#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# IAM 

module "course-setup" {
  source = "github.com/akhiljayan29aj/terraform-academy-ibmcloud//course-setup?ref=main"

  course_resource_group_id = var.course_resource_group_id
  accgrp_name              = "${var.course_prefix}-AG"
  user_list                = var.user_list
  create_bc                = var.create_bc
  create_iot               = var.create_iot
  create_ml                = var.create_ml
  create_ws                = var.create_ws
  create_vsi               = var.create_vsi
  create_cos               = var.create_cos
}

# VPC

module "vpc-mod" {
  source = "./vpc-mod"

  create_vsi        = var.create_vsi
  course_prefix = var.course_prefix
  course_resource_group_id     = var.course_resource_group_id
  location     = var.location
  image        = var.image
  profile     = var.profile
}


# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning

module "ml" {
  source = "./machine-learning"

  count        = var.create_ml ? 1 : 0
  course_rg_id = var.course_resource_group_id
  location     = var.location
  ml_name      = "${var.course_prefix}-ml"
  ml_plan      = var.ml_plan
}


# Blockchain Platform - https://cloud.ibm.com/catalog/services/blockchain-platform
module "blockchain" {
  source = "./blockchain-platform"

  count        = var.create_bc ? 1 : 0
  course_rg_id = var.course_resource_group_id
  location     = var.location
  bch_name     = "${var.course_prefix}-blockchain"
  bch_plan     = var.bch_plan
}

# IOT Platform - https://cloud.ibm.com/catalog/services/internet-of-things-platform
module "iot" {
  source = "./iot-platform"

  count        = var.create_iot ? 1 : 0
  course_rg_id = var.course_resource_group_id
  location     = var.location
  iot_name     = "${var.course_prefix}-iot"
  iot_plan     = var.iot_plan
}

# Watson Studio - https://cloud.ibm.com/catalog/services/watson-studio
module "watson-studio" {
  source = "./watson-studio"

  count        = var.create_ws ? 1 : 0
  course_rg_id = var.course_resource_group_id
  location     = var.location
  ws_name      = "${var.course_prefix}-watson"
  ws_plan      = var.ws_plan
}

module "cos" {
  source = "./cos"

  count        = var.create_cos ? 1 : 0
  course_rg_id = var.course_resource_group_id
  location     = var.location
  cos_name      = var.cos_name
  cos_plan      = var.cos_plan
}