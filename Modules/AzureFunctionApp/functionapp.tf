# Modules/AzureFunctionApp/functionapp.tf

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.storage_account_resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "asp" {
  name                = "azure-functions-test-service-plan"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_application_insights" "ai" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.app_insights_resource_group_name
  application_type    = "web"
}

resource "azurerm_function_app" "fa" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  https_only = var.https_only
  always_on = var.always_on
  tags = var.tags
}