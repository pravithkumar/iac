resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_app_service_environment_v3" "ase" {
  name                = var.ase_name
  resource_group_name = var.ase_resource_group_name
}

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group_name
  
}

data "azurerm_storage_account_keys" "storage_keys" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group_name
  primary_access_key  =var.storage_account_access_key
}

resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Windows"
  reserved            = true

  sku {
    tier = "IsolatedV2"
    size = "I1V2"
  }

  app_service_environment_id = data.azurerm_app_service_environment_v3.ase.id
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.asp.id
  storage_account_name = data.azurerm_storage_account.storage.name
  storage_account_access_key = data.azurerm_storage_account_keys.storage_keys.primary_access_key
}