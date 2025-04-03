resource "azurerm_log_analytics_workspace" "law" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
    dynamic "retention" {
      for_each = var.retention_in_days != null ? [var.retention_in_days] : []
      content {
      retention_in_days = var.retention_in_days
    }
    //   retention_in_days   = 30
}