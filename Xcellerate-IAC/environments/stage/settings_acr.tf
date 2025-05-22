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
          identity_ids = [module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].id]
        }

        encryption = {
          enabled            = false
          key_vault_key_id   = ""
          identity_client_id = ""
        }

        private_endpoint = {
          subnet_id            = data.azurerm_subnet.snet_pe.id
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
