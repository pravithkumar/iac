variable "settings" {
  description = "configure acr resources"
  type = object({
    location                      = string
    resource_group_name           = string
    name                          = string
    sku                           = optional(string, "Standard")
    admin_enabled                 = optional(bool, false)
    zone_redundancy_enabled       = optional(bool, true)
    network_rule_bypass_option    = optional(bool, true)
    data_endpoint_enabled         = optional(bool)
    public_network_access_enabled = optional(bool, true)
    quarantine_policy_enabled     = bool
    tags                          = optional(map(string))

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    encryption = optional(object({
      key_vault_key_id   = string
      identity_client_id = string
    }))

    georeplications = optional(list(object({
      location                  = string
      zone_redundancy_enabled   = bool
      regional_endpoint_enabled = bool
    })))

    network_rule_set = optional(object({
      default_action = optional(string)
      ip_range       = optional(list(string), [])
      subnet_id      = optional(list(string), [])
    }))

    private_endpoint = optional(object({
      subnet_id            = string
      private_dns_zone_ids = optional(list(string))
    }))

    private_endpoint_secondary = optional(list(object({
      endpoint_name        = string
      subnet_id            = string
      connection_name      = string
      private_dns_zone_ids = optional(list(string))
      subresource_names    = list(string)
    })))


    private_endpoints = optional(list(object({
      name                          = string
      subnet_id                     = string
      custom_network_interface_name = optional(string)
      private_service_connection = optional(object({
        name                              = string
        private_connection_resource_id    = optional(string)
        is_manual_connection              = bool
        subresource_names                 = list(string)
        private_connection_resource_alias = optional(string)
        request_message                   = optional(string)
      }))
      private_dns_zone_group = optional(object({
        name                 = string
        private_dns_zone_ids = list(string)
      }))
      ip_configuration = optional(list(object({
        name               = string
        subresource_name   = string
        private_ip_address = optional(string)
        member_name        = optional(string)
      })))
    })))

  })
}
