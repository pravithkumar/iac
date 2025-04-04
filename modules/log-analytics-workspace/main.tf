resource "azurerm_log_analytics_workspace" "law" {
  name                = var.law_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days != null ? var.retention_in_days : null
  dynamic "identity" {
  for_each = var.identity != null ? [1] : []
  content {
    type       = var.identity.type
    identity_ids = var.identity.type == "UserAssigned" ? var.identity.identity_ids : null
  }
}
  tags                = var.tags
}