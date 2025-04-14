resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
  tags                     = var.tags

  https_traffic_only_enabled = var.https_traffic_only_enabled

  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}
}

resource "azurerm_advanced_threat_protection" "example" {
  target_resource_id = azurerm_storage_account.sa.id
  enabled            = var.advanced_threat_protection_enabled
}
