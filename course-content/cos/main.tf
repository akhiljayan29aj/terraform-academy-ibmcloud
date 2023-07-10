#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# COS
resource "ibm_resource_instance" "cloud-object-storage" {
  name              = var.cos_name
  service           = "cloud-object-storage"
  plan              = var.cos_plan
  location          = "global"
  resource_group_id = var.course_rg_id
}
