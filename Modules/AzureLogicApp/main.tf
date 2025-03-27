data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

data "azurerm_app_service_environment_v3" "ase" {
  name                = var.ase_name
  resource_group_name = var.ase_resource_group_name
}

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group_name
  
}

data "azurerm_user_assigned_identity" "mi" {
  name                = var.user_assigned_identity_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name    
  os_type = "Windows"
  sku_name = "I1v2"

 
  app_service_environment_id = data.azurerm_app_service_environment_v3.ase.id
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_service_plan.asp.id
  storage_account_name = data.azurerm_storage_account.storage.name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key

  identity {
    type         = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.mi.id]
  }
}

resource "azurerm_role_assignment" "mi" {
  scope                = data.azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_user_assigned_identity.mi.principal_id
}