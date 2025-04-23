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

resource "azurerm_api_management_identity_provider_aad" "api-aad" {
  api_management_name = azurerm_api_management.api.name
  resource_group_name = var.resource_group_name 

  client_id     = var.client_id
  client_secret = var.client_secret
  client_library = "MSAL"  
  allowed_tenants = var.allowed_tenants  
}

resource "azurerm_api_management_logger" "logger" {
  name                = "appinsights_logger"
  api_management_name = azurerm_api_management.api.name
  resource_group_name = var.resource_group_name
  resource_id         = var.app_insights_id

  application_insights {
    instrumentation_key = var.app_insights_key
  }
}