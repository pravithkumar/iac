data "azurerm_storage_account" "sa" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_service_plan" "asp" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_linux_function_app" "fa" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  service_plan_id            = data.azurerm_service_plan.asp.id
  storage_account_name       = data.azurerm_storage_account.sa.name  
  https_only                 = var.https_only
  public_network_access_enabled = false
  vnet_image_pull_enabled = true
  
  tags                       = var.tags  
  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}
  site_config {
    always_on = var.always_on
    ftps_state = var.ftps_state
    minimum_tls_version = var.minimum_tls_version  
 
    dynamic "application_stack" {
      for_each = var.runtime != null ? [1] : []
      content {       
        dotnet_version = var.runtime == "dotnet" ? var.runtime_version : null       
        java_version = var.runtime == "java" ? var.runtime_version : null
        node_version = var.runtime == "node" ? var.runtime_version : null
        python_version = var.runtime == "python" ? var.runtime_version : null
        powershell_core_version = var.runtime == "powershell" ? var.runtime_version : null      
      }
    }
  }
  app_settings = merge(var.enable_app_insights ? {
      APPINSIGHTS_INSTRUMENTATIONKEY = var.appinsights_instrumentationkey
      APPLICATIONINSIGHTS_CONNECTIONSTRING = var.applicationinsights_connectionstring
    } : {},
    var.app_settings,
  )
 
auth_settings_v2 {
  auth_enabled    = var.auth_enabled

  login {
    allowed_external_redirect_urls = var.allowed_external_redirect_urls
  }

  dynamic "active_directory_v2" {
    for_each = var.auth_enabled ? [1] : []
    content {
      client_id           = var.client_id
      tenant_auth_endpoint = var.tenant_auth_endpoint 
    }
  }
 }
}

