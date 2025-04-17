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


 
auth_settings {
  enabled         = true
  runtime_version = "~2" // auth v2

  dynamic "azure_active_directory_v2" {
    for_each = var.auth_settings_enabled ? [1] : []
    content {
      client_id     = "cfe072e8-149a-4a79-b7d6-9df55eb4aa6b"
      client_secret = "Ih0h~dfkW73DBrfRhgG0ClviDkjD_7aLLR"
      oauth_scopes  = ["openid", "profile", "email"] # Adjust scopes as needed
    }
  }
}


}



resource "azurerm_role_assignment" "function_app_role" {
  scope                = data.azurerm_storage_account.sa.id
  role_definition_name = "Storage Account Contributor" 
  principal_id         = azurerm_linux_function_app.fa.identity[0].principal_id
}