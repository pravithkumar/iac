resource "azurerm_api_management" "api" {
  name                = var.api_management_name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "${var.sku}_${var.sku_count}"
  tags                = var.tags

  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}
}
resource "azurerm_api_management_logger" "logger" {
  name                = "$(var.api_management_name)-logger"
  api_management_name = azurerm_api_management.api.name
  resource_group_name = azurerm_resource_group.api.name
  resource_id         = var.app_insights_id

  application_insights {
    instrumentation_key = var.app_insights_key
  }
}