locals {
  configure_storage_account_resources = {

    settings = {

      "sa${var.app_name}${var.environment}${var.location}001" = {
        name                = "sa${var.app_name}${var.environment}${var.location}001"
        location            = var.location
        resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        tags                = var.tags
        network_rules = {
          virtual_network_subnet_ids = [data.azurerm_subnet.snet_pe.id]
          ip_rules                   = []
          default_action             = "Deny"
        }
        containers               = []
        file_shares              = []
        queues                   = []
        tables                   = []
        account_replication_type = "LRS"
        private_endpoint = {
          subnet_id            = data.azurerm_subnet.snet_pe.id
          private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_blob_core_windows_net.id]
        }
        blob_properties = {
          delete_retention_policy = {
            days                     = 7
            permanent_delete_enabled = true
          }
          container_delete_retention_policy = {
            days = 7
          }
        }
        # queues = [{
        #   name = ""
        # }
        # ]

        # tables = [{
        #   name = ""
        # }
        # ]
      }
    }

  }
}



