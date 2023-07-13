#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

locals {

  primary_network_interface = [{
    subnet               = var.create_vsi ? module.subnet[0].subnet_id : null
    interface_name       = null
    security_groups      = null
    primary_ipv4_address = null
    }
  ]

  sg_rules = [
    for r in local.rules : {
      name       = r.name
      direction  = r.direction
      remote     = lookup(r, "remote", null)
      ip_version = lookup(r, "ip_version", null)
      icmp       = lookup(r, "icmp", null)
      tcp        = lookup(r, "tcp", null)
      udp        = lookup(r, "udp", null)
    }
  ]
  rules = [
    {
      name      = "${var.course_prefix}-ingress-1"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 22
        port_max = 22
      }
    },
    {
      name      = "${var.course_prefix}-ingress-2"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 80
        port_max = 80
      }
    },
    {
      name      = "${var.course_prefix}-ingress-3"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 443
        port_max = 443
      }
    },
    {
      name      = "${var.course_prefix}-ingress-4"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 30000
        port_max = 32767
      }
    },
    {
      name      = "${var.course_prefix}-ingress-5"
      direction = "inbound"
      remote    = "0.0.0.0/0"
      udp = {
        port_min = 30000
        port_max = 32767
      }
    },
    {
      name      = "${var.course_prefix}-ingress-6"
      direction = "inbound"
      icmp = {
        type = 8
        code = null
      }
    },
    {
      name      = "${var.course_prefix}-egress-1"
      direction = "outbound"
      remote    = "0.0.0.0/0"
      tcp = {
        port_min = 1
        port_max = 65535
      }
    }
  ]

}