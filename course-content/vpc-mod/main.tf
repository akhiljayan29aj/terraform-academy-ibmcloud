module "vpc" {
  source = "terraform-ibm-modules/vpc/ibm//modules/vpc"

  create_vpc        = var.create_vsi
  vpc_name          = "${var.course_prefix}-vpc"
  resource_group_id = var.course_resource_group_id
}

module "subnet" {
  source = "terraform-ibm-modules/vpc/ibm//modules/subnet"

  count               = var.create_vsi ? 1 : 0
  name                = "${var.course_prefix}-subnet"
  vpc_id              = var.create_vsi ? module.vpc.vpc_id[0] : "vpc"
  resource_group_id   = var.course_resource_group_id
  location            = "${var.location}-1"
  number_of_addresses = 256
}

# Security Rules for VPC

module "default_sg_rules" {
  source  = "terraform-ibm-modules/vpc/ibm//modules/security-group"
  version = "1.0.0"

  count                 = var.create_vsi ? 1 : 0
  create_security_group = false
  security_group        = module.vpc.vpc_default_security_group[0]
  resource_group_id     = var.course_resource_group_id
  security_group_rules  = local.sg_rules
}

# VSI for VPC

data "ibm_is_image" "rhel7" {
  name = var.image
}

resource "tls_private_key" "example" {
  count     = var.create_vsi ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "ibm_is_ssh_key" "vpc_ssh" {
  count          = var.create_vsi ? 1 : 0
  name           = "${var.course_prefix}-ssh"
  resource_group = var.course_resource_group_id
  public_key     = tls_private_key.example[0].public_key_openssh
}

module "vsi" {
  source                    = "terraform-ibm-modules/vpc/ibm//modules/instance"
  no_of_instances           = var.create_vsi ? 1 : 0
  name                      = "${var.course_prefix}-vsi"
  vpc_id                    = var.create_vsi ? module.vpc.vpc_id[0] : null
  resource_group_id         = var.course_resource_group_id
  location                  = "${var.location}-1"
  image                     = data.ibm_is_image.rhel7.id
  profile                   = var.profile
  ssh_keys                  = var.create_vsi ? [ibm_is_ssh_key.vpc_ssh[0].id] : null
  primary_network_interface = local.primary_network_interface
}


output "vpcid" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
  sensitive   = false
}

output "subnetids" {
  value       = module.vpc.subnet_ids
  description = "SUBNET IDs"
  sensitive   = false
}