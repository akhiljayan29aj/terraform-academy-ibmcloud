#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "course_governance" {
  source = "./course-governance"

  ibmcloud_api_key  = var.ibmcloud_api_key
  user_list         = var.user_list
  decomission_timer = var.decomission_timer
  course_prefix     = var.course_prefix
  create_bc         = var.create_bc
  bch_plan          = var.bch_plan
  create_iot        = var.create_iot
  iot_plan          = var.iot_plan
  create_ml         = var.create_ml
  ml_plan           = var.ml_plan
  create_ws         = var.create_ws
  ws_plan           = var.ws_plan
  create_vsi        = var.create_vsi
  image             = var.image
  profile           = var.profile
}