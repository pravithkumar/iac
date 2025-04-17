data "azurerm_storage_account" "sa" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_function_app" "fa" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = data.azurerm_service_plan.asp.id
  storage_account_name       = data.azurerm_storage_account.sa.name
  storage_account_access_key = data.azurerm_storage_account.sa.primary_access_key
  https_only                 = var.https_only
  tags                       = var.tags
  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}
  site_config {
    always_on = var.always_on
  }
  app_settings = merge(var.enable_app_insights ? {
      APPINSIGHTS_INSTRUMENTATIONKEY = var.appinsights_instrumentationkey
      APPLICATIONINSIGHTS_CONNECTIONSTRING = var.applicationinsights_connectionstring
    } : {},
    var.app_settings,
  )
}

resource "azurerm_app_service_auth_settings_v2" "auth" {
  name                = azurerm_linux_function_app.fa.name
  resource_group_name = var.resource_group_name
  enabled             = true
  unauthenticated_client_action = "RedirectToLoginPage"
  token_store_enabled           = true
  allowed_external_redirect_urls = [
    "https://example.com/redirect"
  ]
  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_linux_function_app.fa]
}

resource "azurerm_role_assignment" "function_app_role" {
  scope                = data.azurerm_storage_account.sa.id
  role_definition_name = "Storage Account Contributor" 
  principal_id         = azurerm_linux_function_app.fa.identity[0].principal_id
}