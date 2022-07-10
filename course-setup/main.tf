#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

module "iam_policy" {
  source            = "./iam-access-policy"
  
  resource_group_id = var.course_resource_group_id
  accgrp_name       = var.accgrp_name
  user_list         = var.user_list
  create_bc         = var.create_bc
  create_iot        = var.create_iot
  create_ml         = var.create_ml
  create_ws         = var.create_ws
  create_vsi        = var.create_vsi
}