resource "azurerm_key_vault" "key_vault" {

  name                            = var.azurerm_key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption  
  soft_delete_retention_days      = var.soft_delete_retention_days
  purge_protection_enabled        = var.purge_protection_enabled
  tags                            = var.tags
  sku_name                        = var.sku_name
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enabled_for_deployment          = var.enabled_for_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  public_network_access_enabled   = var.public_network_access_enabled

  dynamic "network_acls" {
    for_each = var.network_acls != null ? var.network_acls : []

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}