# ../Modules/AzureFunctionApp/functionapp.tf (for very old provider versions)

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group_name
}

resource "azurerm_function_app" "function_app" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key
  https_only                 = var.https_only
  site_config {
    always_on = var.always_on
    ftps_state = "FtpsOnly"
    min_tls_version = "1.2"
    linux_fx_version = var.runtime == "python" ? "PYTHON|${var.runtime_version}" : null
    dotnet_framework_version = var.runtime == "dotnet" ? var.runtime_version : null
    app_settings = {
      "FUNCTIONS_EXTENSION_VERSION"         = "~4"
      "FUNCTIONS_WORKER_RUNTIME"            = var.runtime
      "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = "DefaultEndpointsProtocol=https;AccountName=${data.azurerm_storage_account.storage.name};AccountKey=${data.azurerm_storage_account.storage.primary_access_key}"
      "WEBSITE_CONTENTSHARE"                = lower("${var.function_app_name}content")
      "WEBSITE_RUN_FROM_PACKAGE"            = "1"
      "APPINSIGHTS_INSTRUMENTATIONKEY"      = data.azurerm_application_insights.app_insights.instrumentation_key
    }
  }
  version = "~4"
  tags = var.tags
}