# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

# Resource Group
resource "azurerm_resource_group" "function_rg" {
  name     = var.resource_group_name
  location = var.location
}

# App Service Plan
resource "azurerm_app_service_plan" "appserviceplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.function_rg.location
  resource_group_name = azurerm_resource_group.function_rg.name
  kind                = var.app_service_plan_kind
  reserved            = var.app_service_plan_reserved
  sku {
    tier = var.app_service_plan_tier
    size = var.app_service_plan_size
  }
}

# Storage Account
resource "azurerm_storage_account" "storageaccount" {
  name                     = "${var.storage_account_name}${random_integer.result}"
  resource_group_name      = azurerm_resource_group.function_rg.name
  location                 = azurerm_resource_group.function_rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "random_integer" "random_integer" {
  min = 10000
  max = 99999
}

# Application Insights
resource "azurerm_application_insights" "appinsights" {
  name                = var.application_insights_name
  location            = azurerm_resource_group.function_rg.location
  resource_group_name = azurerm_resource_group.function_rg.name
  application_type    = var.application_insights_type
}

# Function App
resource "azurerm_function_app" "functionapp" {
  name                       = var.function_app_name
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
  }
    identity {
      type = var.function_app_identity_type
  }
}

output "function_app_default_hostname" {
  value = azurerm_function_app.functionapp.default_hostname
}

output "principal_id" {
  value = azurerm_function_app.functionapp.identity[0].principal_id
}