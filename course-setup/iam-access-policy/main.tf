#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

resource "ibm_iam_access_group" "accgrp" {
  name        = var.accgrp_name
  description = "New access group for student's training"
}

resource "ibm_iam_user_invite" "invite_user" {
  users         = var.user_list
  access_groups = [ibm_iam_access_group.accgrp.id]
}

resource "ibm_iam_access_group_policy" "ws-policy" {
  count           = var.create_ws ? 1 : 0
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Editor"] # Service level access not supported.

  resources {
    service           = "data-science-experience"
    resource_group_id = var.resource_group_id
  }
}

resource "ibm_iam_access_group_policy" "ml-policy" {
  count           = var.create_ml ? 1 : 0
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Editor", "Writer"]

  resources {
    service           = "pm-20"
    resource_group_id = var.resource_group_id
  }
}

resource "ibm_iam_access_group_policy" "bch-policy" {
  count           = var.create_bc ? 1 : 0
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Editor"]

  resources {
    service           = "blockchain"
    resource_group_id = var.resource_group_id
  }
}


resource "ibm_iam_access_group_policy" "iotf-policy" {
  count           = var.create_iot ? 1 : 0
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Editor"]

  resources {
    service           = "iotf-service"
    resource_group_id = var.resource_group_id
  }
}


resource "ibm_iam_access_group_policy" "rg-policy" {
  access_group_id = ibm_iam_access_group.accgrp.id
  roles           = ["Viewer"]

  resources {
    resource_type = "resource-group"
    resource      = var.resource_group_id
  }
}
