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

resource "azurerm_api_management_identity_provider_aad" "example" {
  api_management_name = azurerm_api_management.api.name
  resource_group_name = var.resource_group_name

  client_id     = "cfe072e8-149a-4a79-b7d6-9df55eb4aa6b"
  client_secret = "Ih0h~dfkW73DBrfRhgG0ClviDkjD_7aLLR"
  allowed_tenants = [
    "188285f7-8f1e-4c0d-a0bc-797e3e38c5b3"
  ]
  client_library = "MSAL"
  redirect_url   = "https://your-redirect-url"
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