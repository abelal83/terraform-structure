variable "settings" {
  type = object({
    environment_name = string
    region           = string
    location         = string
    subscription_id  = string
    traffic_managers = map(object({
      monitor_endpoint = optional(string, "/ready")
      name = string
      routing_method = string
      host_header = string
      endpoints = map(object(
        {
          name               = string
          target             = optional(string)
          target_resource_id = optional(string)
          type               = optional(string)
          weight             = optional(number)
      }))
    }))
  })
  description = <<-EOT
    (Required) A map of traffic manager profiles and endpoints to be created."
  EOT
}
