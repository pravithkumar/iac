variable "settings" {
  type = object({
    name                          = string
    location                      = string
    resource_group_name           = string
    capacity                      = number
    sku_name                      = string
    minimum_tls_version           = optional(string, "1.2")
    enable_non_ssl_port           = optional(bool, false)
    public_network_access_enabled = optional(bool, false)
    tags                          = optional(map(string), null)
    shard_count                   = optional(number, 1)

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    redis_configuration = optional(object({
      enable_authentication           = optional(bool, true)
      maxmemory_reserved              = optional(number, 10)
      maxmemory_delta                 = optional(number, 2)
      maxfragmentationmemory_reserved = optional(number, 10)
      maxmemory_policy                = optional(string, null)
      rdb_backup_enabled              = optional(bool, false)
      rdb_backup_frequency            = optional(number, 60)
      rdb_backup_max_snapshot_count   = optional(number, null)
    }))

    private_endpoint = optional(object({
      subnet_id            = string
      private_dns_zone_ids = optional(list(string))
    }))

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
