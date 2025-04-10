provider "azurerm" {
  alias           = "integ-mgmt-001"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}

data "azurerm_storage_account" "sa" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
}

data "azurerm_application_insights" "ai" {
  provider            = azurerm.integ-mgmt-001
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group_name
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

    dynamic "app_settings" {
      for_each = var.enable_app_insights ? [1] : [] # Use a boolean variable to control inclusion
      content {
        APPINSIGHTS_INSTRUMENTATIONKEY = data.azurerm_application_insights.ai.instrumentation_key
        APPLICATIONINSIGHTS_CONNECTIONSTRING = data.azurerm_application_insights.ai.connection_string
      }
    }
  }
}