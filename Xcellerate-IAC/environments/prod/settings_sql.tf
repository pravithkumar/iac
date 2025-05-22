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
        primary_user_assigned_identity_id = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.id
        # transparent_data_encryption_key_vault_key_id = "https://kv-xl-prod-eastus-001.vault.azure.net/keys/keyaksxlprodeastus001/be821ae72bac47929eac63d0274a0214"

        identity = {
          type         = "UserAssigned"
          identity_ids = [data.azurerm_user_assigned_identity.mi_xl_prod_location_001.id]
        }
        azuread_administrator = {
          login_username              = "mi-${var.app_name}-${var.environment}-${var.location}-001"
          object_id                   = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
          azuread_authentication_only = true
        }


        # key_vault_secret = [
        #   {
        #     name         = "secret-sql-gyx-prd-m42-aen"
        #     key_vault_id = local.kv.dependency.kv.outputs.this[include.env.locals.kv_name].id
        #   }



        private_endpoint = {
          subnet_id            = data.azurerm_subnet.snet_xl_prod_pe_001.id
          private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_database_windows_net.id]
        }

        mssql_database = [
          {
            name                 = "XCELLERATE-PROD"
            collation            = "SQL_Latin1_General_CP1_CI_AS"
            sku_name             = "GP_Gen5_2"
            geo_backup_enabled   = true
            zone_redundant       = false
            storage_account_type = "Geo"
            license_type         = "LicenseIncluded"
            read_replica_count   = 0
            read_scale           = false
            max_size_gb          = 10
            # transparent_data_encryption_key_vault_key_id = local.kv.dependency.kv.outputs.this[include.env.locals.kv_name].key_id["key-mssql-rsahsm"]
            transparent_data_encryption_enabled = true

            identity = {
              type         = "UserAssigned"
              identity_ids = [data.azurerm_user_assigned_identity.mi_xl_prod_location_001.id]
            }


          }
        ]
      }
    }
  }
}
