locals {
  prefix = "abx-trafficmgr"

  # we merge static values with variables values to form a single configuration object
  config = merge(
    var.settings,
    {
      resource_group_name = "${local.prefix}-${var.settings.environment_name}-rg-01",
      prefix              = local.prefix
      traffic_manager_prefix = local.prefix
    }
  )
}