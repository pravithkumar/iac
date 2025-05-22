locals {
  configure_acr_resources = {

    settings = {

      "acr${var.app_name}${var.environment}${var.location}001" = {
        name                          = "acr${var.app_name}${var.environment}${var.location}001"
        resource_group_name           = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        location                      = var.location
        tags                          = var.tags
        sku                           = "Premium"
        admin_enabled                 = false
        public_network_access_enabled = false
        zone_redundancy_enabled       = true
        quarantine_policy_enabled     = false
        trust_policy                  = false

        identity = {
          type         = "UserAssigned"
          identity_ids = [data.azurerm_user_assigned_identity.mi_xl_prod_location_001.id]
        }

        encryption = {
          enabled          = false
          key_vault_key_id = ""
          #key_vault_key_id   = local.dependency.dependency.kv.outputs.this["akvgensenseprdm42aen001"].key_versionless_id["key-acr-rsahsm"]
          #identity_client_id = "cffdeff6-e2b3-4cdf-aff1-4808098fe18f"
          identity_client_id = ""
        }

        private_endpoint = {
          subnet_id            = data.azurerm_subnet.snet_xl_prod_pe_001.id
          private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_azurecr_io.id]
        }

        retention_policy = {
          enabled = false
          days    = 7
        }
      }
    }
  }
}
