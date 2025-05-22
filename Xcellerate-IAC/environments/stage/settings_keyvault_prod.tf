locals {
  configure_kv_prod_resources = {

    settings = {

      "kv-${var.app_name}-${var.environment}-${var.location}-001" = {
        azurerm_key_vault_name          = "kv-${var.app_name}-${var.environment}-${var.location}-001"
        resource_group_name             = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        location                        = var.location
        tags                            = var.tags
        enabled_for_disk_encryption     = true
        tenant_id                       = data.azurerm_client_config.this.tenant_id 
        soft_delete_retention_days      = 90
        purge_protection_enabled        = true
        tags                            = var.tags
        sku_name                        = "standard"
        enabled_for_template_deployment = true
        enabled_for_deployment          = true
        enable_rbac_authorization       = true
        public_network_access_enabled   = false
        network_acls                    = []
        key_vault_key = [
        ]
        vm_ssh_generate = [
        ]
        private_endpoint = {
          subnet_id            = data.azurerm_subnet.snet_pe.id 
          private_dns_zone_ids = [data.azurerm_private_dns_zone.privatelink_vaultcore_azure_net.id] 
        }
      }
    }
  }
}
