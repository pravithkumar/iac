data "azurerm_app_service_environment_v3" "ase" {
  name                = var.ase_name
  resource_group_name = var.ase_resource_group_name
}

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group_name
  
}

resource "azurerm_service_plan" "logicasp" {
  name                = var.app_service_plan_name_1
  location            = var.location
  resource_group_name = var.resource_group_name    
  os_type = var.os_type
  sku_name = var.sku_name

 
  app_service_environment_id = data.azurerm_app_service_environment_v3.ase.id
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.logicasp.id
  storage_account_name = data.azurerm_storage_account.storage.name
  storage_account_access_key = var.storage_account_access_key   

  site_config {
    always_on = false
  }
  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}
}

resource "azurerm_role_assignment" "mi" {
  scope                = data.azurerm_storage_account.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_logic_app_standard.logic_app.identity[0].principal_id  
}
