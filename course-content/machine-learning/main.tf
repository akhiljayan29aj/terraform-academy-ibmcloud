#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# Machine Learning - https://cloud.ibm.com/catalog/services/machine-learning
resource "ibm_resource_instance" "pm-20" {
  name              = var.ml_name
  service           = "pm-20"
  plan              = var.ml_plan
  location          = var.location
  resource_group_id = var.course_rg_id
}
