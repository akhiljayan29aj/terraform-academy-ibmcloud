#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

resource "ibm_resource_group" "rg" {
  name = var.rg_name
}
