#####################################################
# IBM Cloud - Terraform Academy Training
# Copyright 2022 IBM
#####################################################

resource "ibm_function_namespace" "namespace" {
  name              = var.namespace
  resource_group_id = ibm_resource_group.rg.id
}

resource "ibm_function_action" "action" {
  name      = var.action_name
  namespace = ibm_function_namespace.namespace.name

  exec {
    kind = "python:3.9"
    code = file("${path.module}/scripts/schematics_decommission.py")
  }
}

resource "ibm_function_trigger" "trigger" {
  for_each = { for k, instance in flatten(local.workspace_decommission_list) : k => instance }

  name      = format("%s-%s-%s", var.trigger_name, var.decomission_timer, each.value["prop"]["index"])
  namespace = ibm_function_namespace.namespace.name
  feed {
    name       = "/whisk.system/alarms/alarm"
    parameters = <<EOF
		[
			{
				"key":"cron",
				"value":"${each.value["prop"]["cron_expr"]}"
			}
		]
	EOF
  }

  user_defined_parameters = <<EOF
	   [
	  	{
	   		"key":"apikey",
	   		"value":"${base64encode(var.user_list[each.key]["apikey"])}"
	  	},
      {
	   		"key":"decomission_timer",
	   		"value":"${var.decomission_timer}"
	  	},
      {
	   		"key":"workspace_id",
	   		"value":"${each.value["prop"]["workspace_id"]}"
	  	}
	   ]
	EOF

  depends_on = [ibm_function_action.action]
}

resource "ibm_function_rule" "rule" {
  count = length(var.user_list)

  name         = "${var.rule_name}-${count.index}"
  namespace    = ibm_function_namespace.namespace.name
  trigger_name = ibm_function_trigger.trigger[count.index].name
  action_name  = ibm_function_action.action.name
}