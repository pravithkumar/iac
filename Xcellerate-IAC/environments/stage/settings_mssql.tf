locals {
  configure_mssql_resources = {

    settings = {

      "sql-${var.app_name}-${var.environment}-${var.location}-01" = {
        resource_group_name               = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        name                              = "sql-${var.app_name}-${var.environment}-${var.location}-001"
        location                          = var.location
        tags                              = var.tags
        version                           = "12.0"
        administrator_login               = "ftreadminuser"
        public_network_access_enabled     = false
        primary_user_assigned_identity_id = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].id

        identity = {
          type         = "UserAssigned"
          identity_ids = [module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].id]
        }

        azuread_administrator = {
          login_username              = "mi-${var.app_name}-${var.environment}-${var.location}-001"
          object_id                   = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
          azuread_authentication_only = true
        }

        private_endpoint = {
          subnet_id            = data.azurerm_subnet.snet_pe.id
          private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_database_windows_net.id]
        }

        mssql_database = [
          {
            name                                = var.mssql_db_name
            collation                           = "SQL_Latin1_General_CP1_CI_AS"
            sku_name                            = "GP_Gen5_2"
            geo_backup_enabled                  = true
            zone_redundant                      = false
            storage_account_type                = "Geo"
            license_type                        = "LicenseIncluded"
            read_replica_count                  = 0
            read_scale                          = false
            max_size_gb                         = 10
            transparent_data_encryption_enabled = true

            identity = {
              type         = "UserAssigned"
              identity_ids = ["/subscriptions/${var.rg1_subscription_id}/resourceGroups/${var.rg1_resource_group_name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/mi-${var.app_name}-${var.environment}-${var.location}-001"]
            }
          }
        ]
      }
    }
  }
}
