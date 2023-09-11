locals {
  environment_name = "dev"
  api_dns_suffix = "-dev"
  ui_dns_suffix = "-dev"
  subscription_id = "/subscriptions/xxxxxxxxxxxxxxxxxx"

  abx_aks01_ne_target_id = "${local.subscription_id}/resourceGroups/abx-network-${local.environment_name}-rg-01/providers/Microsoft.Network/publicIPAddresses/abx-aks01-${local.environment_name}-ne-pip-01"
  abx_aks01_we_target_id = "${local.subscription_id}/resourceGroups/abx-network-${local.environment_name}-rg-01/providers/Microsoft.Network/publicIPAddresses/abx-aks01-${local.environment_name}-we-pip-01"
  abx_aks01_hostname = "abx-aks01-${local.environment_name}.abx.live"
}