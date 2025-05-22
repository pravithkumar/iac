variable "settings" {
  description = "Storage account configurations"
  type = object({
    name                              = string
    location                          = string
    resource_group_name               = string
    account_kind                      = optional(string, "StorageV2")
    account_tier                      = optional(string, "Standard")
    account_replication_type          = optional(string, "LRS")
    access_tier                       = optional(string)
    edge_zone                         = optional(string, null)
    shared_access_key_enabled         = optional(bool, true)
    large_file_share_enabled          = optional(bool, false)
    nfsv3_enabled                     = optional(bool, false)
    tags                              = optional(map(string), null)
    public_network_access_enabled     = optional(bool, false)
    infrastructure_encryption_enabled = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    storage_subnet_id                 = optional(string, "")
    is_hns_enabled                    = optional(bool)
    https_traffic_only_enabled        = optional(bool)
    cross_tenant_replication_enabled  = optional(bool)
    sftp_enabled                      = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    # dns_endpoint_type             = optional(string, "AzureDnsZone")

    network_rules = optional(object({
      bypass                     = optional(list(string))
      virtual_network_subnet_ids = optional(list(string))
      ip_rules                   = optional(list(string))
      default_action             = string

      private_link_access = optional(list(object({
        endpoint_resource_id = string
        endpoint_tenant_id   = optional(string)
      })))
    }))

    blob_properties = optional(object({

      delete_retention_policy = optional(object({
        days                     = optional(number)
        permanent_delete_enabled = optional(bool)
      }))

      restore_policy = optional(object({
        days = optional(number)
      }))


      container_delete_retention_policy = optional(object({
        days = optional(number)
      }))

      versioning_enabled       = optional(bool)
      last_access_time_enabled = optional(bool)
      change_feed_enabled      = optional(bool)
    }))


    static_website = optional(object({
      index_document     = string
      error_404_document = optional(string)
    }))

    customer_managed_key = optional(object({
      key_vault_key_id          = optional(string)
      managed_hsm_key_id        = optional(string)
      user_assigned_identity_id = string
    }))


    routing = optional(object({
      publish_internet_endpoints  = string
      publish_microsoft_endpoints = string
      choice                      = string
    }))

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))


    containers = optional(list(object({
      name = string
    })))


    blob_inventory_policy = optional(list(object({
      name = string
      rules = list(object({
        name                   = string
        storage_container_name = string
        format                 = string
        schedule               = string
        scope                  = string
        schema_fields          = list(string)

        filter = optional(object({
          blob_types            = optional(list(string))
          include_blob_versions = optional(bool)
          include_deleted       = optional(bool)
          include_snapshots     = optional(bool)
          prefix_match          = optional(list(string))
          exclude_prefixes      = optional(list(string))
        }))
      }))
    })))



    file_shares = optional(list(object({
      name             = string
      quota_in_gb      = optional(number, 50)
      enabled_protocol = optional(string)
      metadata         = optional(map(string))
      acl = optional(list(object({
        id          = string
        permissions = string
        start       = optional(string)
        expiry      = optional(string)
      })))
    })))

    queues = optional(list(object({
      name = string
    })))

    tables = optional(list(object({
      name = string
    })))

    private_endpoint = optional(object({
      subnet_id                     = string
      custom_network_interface_name = optional(string)
      private_dns_zone_ids          = optional(list(string))
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
