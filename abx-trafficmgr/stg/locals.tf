locals {
  settings = {
    environment_name = local.environment_name
    region           = "we" # where the metadata for traffic manager will reside
    subscription_id = local.subscription_id
    location         = "westeurope" # where the metadata for traffic manager should reside but traffic manager is global.
    traffic_managers = local.traffic_managers
  }
}

locals {

  # to avoid Error: Cycle: local.traffic_managers (expand), local.settings (expand), module.config.var.settings (expand), module.config.local.config (expand), module.config.output.config (expand)
  traffic_managers = {
    carbonapi_01 = {
      name           = "abx-trafficmgrcarbonapi-${local.environment_name}-glb-traf-01"
      routing_method = "Performance"
      host_header    = "abx-carbonapi${local.api_dns_suffix}.abx.live"
      monitor_endpoint = "/readyz"
      endpoints = {
        we = {
          name               = "abxkswe01"
          target_resource_id = local.abx_aks01_we_target_id
        }
        ne = {
          name               = "abxksne01"
          target_resource_id = local.abx_aks01_ne_target_id
        }
      }
    }

    cmplncemgrui_01 = {
      name           = "abx-trafficmgrcmplncemgrui-${local.environment_name}-glb-traf-01"
      routing_method = "Performance"
      host_header    = "compliance-manager${local.ui_dns_suffix}.abx.live"
      monitor_endpoint = "/api/readyz"
      endpoints = {
        we = {
          name               = "abxkswe01"
          target_resource_id = local.abx_aks01_we_target_id
        }
        ne = {
          name               = "abxksne01"
          target_resource_id = local.abx_aks01_ne_target_id
        }
      }
    }

    sereneui_01 = {
      name           = "abx-trafficmgrsereneui-${local.environment_name}-glb-traf-01"
      routing_method = "Performance"
      host_header    = "serene${local.ui_dns_suffix}.abx.live"
      monitor_endpoint = "/readyz"
      endpoints = {
        we = {
          name               = "abxkswe01"
          target_resource_id = local.abx_aks01_we_target_id
        }
        ne = {
          name               = "abxksne01"
          target_resource_id = local.abx_aks01_ne_target_id
        }
      }
    }

    carbonexposure_01 = {
      name           = "abx-trafficmgrcarbonexposureui-${local.environment_name}-glb-traf-01"
      routing_method = "Performance"
      host_header    = "carbon-exposure${local.ui_dns_suffix}.abx.live"
      monitor_endpoint = "/api/readyz"
      endpoints = {
        we = {
          name               = "abxkswe01"
          target_resource_id = local.abx_aks01_we_target_id
        }
        ne = {
          name               = "abxksne01"
          target_resource_id = local.abx_aks01_ne_target_id
        }
      }
    }

    abxexample_01 = {
      name           = "abx-trafficmgrabxexample-${local.environment_name}-glb-traf-01"
      routing_method = "Performance"
      host_header    = "abxexample-staging.abx.live"
      monitor_endpoint = "/readyz"
      endpoints = {
        we = {
          name               = "abxkswe01"
          target_resource_id = local.abx_aks01_we_target_id
        }
        ne = {
          name               = "abxksne01"
          target_resource_id = local.abx_aks01_ne_target_id
        }
      }
    }
  }
}