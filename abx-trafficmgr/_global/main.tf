

resource "azurerm_traffic_manager_profile" "this" {

  for_each = var.config.traffic_managers

  name                   = each.value.name
  resource_group_name    = var.config.resource_group_name
  traffic_routing_method = each.value.routing_method
  traffic_view_enabled   = true

  dns_config {
    relative_name = each.value.name
    ttl           = 100
  }

  monitor_config {
    protocol                     = "HTTPS"
    port                         = 443
    path                         = each.value.monitor_endpoint
    interval_in_seconds          = 30
    timeout_in_seconds           = 9
    tolerated_number_of_failures = 3
    custom_header {
      name  = "host"
      value = each.value.host_header
    }
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

locals {
  endpoints_flatten = flatten([
    for traffic_manager_key, traffic_manager_values in var.config.traffic_managers : [
      for endpoint in traffic_manager_values.endpoints : {
        traffic_manager_key = traffic_manager_key
        name                = endpoint.name
        target_resource_id  = endpoint.target_resource_id
      }
    ]
  ])

  endpoints = { for k, v in local.endpoints_flatten : "${v.traffic_manager_key}.${v.name}" => v }
}

resource "azurerm_traffic_manager_azure_endpoint" "this" {

  for_each = local.endpoints

  name               = each.value.name
  profile_id         = azurerm_traffic_manager_profile.this[each.value.traffic_manager_key].id
  weight             = 1000
  target_resource_id = each.value.target_resource_id
}
