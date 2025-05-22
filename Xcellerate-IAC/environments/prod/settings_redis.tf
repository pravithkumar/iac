locals {
  configure_redis_resources = {

    settings = {

      "redis-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                          = "redis-${var.app_name}-${var.environment}-${var.location}-001"
        resource_group_name           = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        location                      = var.location
        tags                          = var.tags
        sku_name                      = "Premium"
        minimum_tls_version           = "1.2"
        enable_non_ssl_port           = false
        public_network_access_enabled = false
        capacity                      = 1
        shard_count                   = 1

        identity = {
          type         = "UserAssigned"
          identity_ids = [data.azurerm_user_assigned_identity.mi_xl_prod_location_001.id]
        }
        redis_configuration = {
          enable_authentication           = true
          maxmemory_reserved              = 642 #10
          maxmemory_delta                 = 642 #2
          maxfragmentationmemory_reserved = 642 #10
          maxmemory_policy                = null
          rdb_backup_enabled              = false
          rdb_backup_frequency            = 60
          rdb_backup_max_snapshot_count   = null
        }
        private_endpoint = {
          subnet_id                     = data.azurerm_subnet.snet_xl_prod_pe_001.id
          private_dns_zone_ids          = [data.azurerm_private_dns_zone.privatelink_redis_cache_windows_net.id]
          custom_network_interface_name = "nic-pe-redis-${var.app_name}-${var.environment}-${var.location}-001"
        }
        private_endpoints = []
      }
    }
  }
}

