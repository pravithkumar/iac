# source.tf (Example using a local zip file for the function app code)

data "archive_file" "function_code" {
  type        = "zip"
  source_dir  = "./function_code" # Path to your function code directory
  output_path = "./function_code.zip"
}

resource "azurerm_storage_blob" "function_zip" {
  name                   = "function_code.zip"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = "function-code"
  type                   = "Block"
  source                 = data.archive_file.function_code.output_path
}

resource "azurerm_function_app_slot" "functionappslot" {
  name                       = "function-app-slot"
  location                   = azurerm_resource_group.function_rg.location
  resource_group_name        = azurerm_resource_group.function_rg.name
  app_service_plan_id        = azurerm_app_service_plan.appserviceplan.id
  storage_account_name       = azurerm_storage_account.storageaccount.name
  storage_account_access_key = azurerm_storage_account.storageaccount.primary_access_key
  version                    = var.function_app_version
  https_only                 = var.function_app_https_only
  site_config {
    always_on = var.function_app_always_on
    application_stack {
      python_version = var.python_version
    }
    cors {
      allowed_origins = var.allowed_origins
    }
  }

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY = azurerm_application_insights.appinsights.instrumentation_key
    FUNCTIONS_WORKER_RUNTIME        = var.function_worker_runtime
    AzureWebJobsStorage             = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.storageaccount.name};AccountKey=${azurerm_storage_account.storageaccount.primary_access_key};EndpointSuffix=core.windows.net"
    WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.storageaccount.name}.blob.core.windows.net/function-code/function_code.zip?${azurerm_storage_blob.function_zip.url_sas_token}"
  }

  identity {
      type = var.function_app_identity_type
  }
}

resource "azurerm_storage_container" "function_container" {
  name                  = "function-code"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"
}

resource "azurerm_storage_blob_sas" "function_zip_sas" {
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = azurerm_storage_container.function_container.name
  storage_blob_name       = azurerm_storage_blob.function_zip.name
  https_only             = true
  start                  = "2023-01-01T00:00:00Z"
  expiry                 = "2030-01-01T00:00:00Z" # Adjust expiration as needed
  permissions {
    read = true
    list = true
  }
}

output "function_code_zip_url" {
  value = "https://${azurerm_storage_account.storageaccount.name}.blob.core.windows.net/function-code/function_code.zip?${azurerm_storage_blob_sas.function_zip_sas.url}"
}