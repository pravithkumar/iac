# ../Modules/AzureFunctionApp/functionapp.tf

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
    # Older provider versions use linux_fx_version or windows_fx_version
    linux_fx_version = var.runtime == "python" ? "PYTHON|${var.runtime_version}" : null
    dotnet_framework_version = var.runtime == "dotnet" ? var.runtime_version : null
    # Add other runtimes as needed
  }
  version = "~4"
  tags = var.tags

  app_setting {
    name  = "FUNCTIONS_EXTENSION_VERSION"
    value = "~4"
  }

  app_setting {
    name  = "FUNCTIONS_WORKER_RUNTIME"
    value = var.runtime
  }

  app_setting {
    name  = "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING"
    value = "DefaultEndpointsProtocol=https;AccountName=${data.azurerm_storage_account.storage.name};AccountKey=${data.azurerm_storage_account.storage.primary_access_key}"
  }

  app_setting {
    name  = "WEBSITE_CONTENTSHARE"
    value = lower("${var.function_app_name}content")
  }

  app_setting {
    name  = "WEBSITE_RUN_FROM_PACKAGE"
    value = "1"
  }

  app_setting {
    name = "APPINSIGHTS_INSTRUMENTATIONKEY"
    value = data.azurerm_application_insights.app_insights.instrumentation_key
  }
}