# ../Modules/AzureFunctionApp/main.tf

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
    always_on              = var.always_on
    ftps_state             = "FtpsOnly"
    min_tls_version        = "1.2"
    linux_fx_version       = var.runtime == "python" ? "PYTHON|${var.runtime_version}" : null
    dotnet_framework_version = var.runtime == "dotnet" ? var.runtime_version : null
  }
  version = "~4"
  tags    = var.tags

  app_setting_FUNCTIONS_EXTENSION_VERSION         = "~4"
  app_setting_FUNCTIONS_WORKER_RUNTIME            = var.runtime
  app_setting_WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = "DefaultEndpointsProtocol=https;AccountName=${data.azurerm_storage_account.storage.name};AccountKey=${data.azurerm_storage_account.storage.primary_access_key}"
  app_setting_WEBSITE_CONTENTSHARE                = lower("${var.function_app_name}content")
  app_setting_WEBSITE_RUN_FROM_PACKAGE            = "1"
  app_setting_APPINSIGHTS_INSTRUMENTATIONKEY      = data.azurerm_application_insights.app_insights.instrumentation_key
}

resource "azurerm_private_endpoint" "function_app_pe" {
  name                = "${var.function_app_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.function_app_name}-psc"
    private_connection_resource_id = azurerm_function_app.function_app.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.function_app_name}-dns-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}