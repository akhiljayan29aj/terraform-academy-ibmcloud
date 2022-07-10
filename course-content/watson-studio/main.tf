#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

# Watson Studio - https://cloud.ibm.com/catalog/services/watson-studio
resource "ibm_resource_instance" "data-science-experience" {
  name              = var.ws_name
  service           = "data-science-experience"
  plan              = var.ws_plan
  location          = var.location
  resource_group_id = var.course_rg_id
}
