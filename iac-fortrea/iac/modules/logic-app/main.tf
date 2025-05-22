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
  tags                = var.tags
  sku_name = var.sku_name

 
  app_service_environment_id = data.azurerm_app_service_environment_v3.ase.id
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  tags                = var.tags
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_service_plan.logicasp.id
  storage_account_name = data.azurerm_storage_account.storage.name
  storage_account_access_key = var.storage_account_access_key
  https_only                 = var.https_only
  vnet_content_share_enabled = true

  timeouts {
   create = "120m"
   delete = "120m"
  }
  site_config {
    always_on = true
    min_tls_version = var.min_tls_version
  }
  app_settings = merge(var.enable_app_insights ? {
      APPINSIGHTS_INSTRUMENTATIONKEY = var.appinsights_instrumentationkey
      APPLICATIONINSIGHTS_CONNECTIONSTRING = var.applicationinsights_connectionstring
    } : {},
    var.app_settings,
    {
      WEBSITE_VNET_ROUTE_ALL = "1"      
    }
  )
  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}
}