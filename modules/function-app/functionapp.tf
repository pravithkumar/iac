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

resource "azurerm_role_assignment" "function_app_role" {
  scope                = azurerm_linux_function_app.fa.id # Replace with your Function App resource ID
  role_definition_name = "Contributor"                               # Or use role_definition_id
  principal_id         = azurerm_function_app.fa.identity[0].principal_id             # Replace with the principal's object ID
}