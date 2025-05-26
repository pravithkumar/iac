data "azurerm_client_config" "current" {}

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "5.1.0"
  default_location = var.identity_resources_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }
# Base configuration settings 
  disable_telemetry            = true
  root_parent_id               = data.azurerm_client_config.current.tenant_id
  root_id                      = var.root_id
  root_name                    = var.root_name
  library_path                 = "${path.root}/lib"
  deploy_core_landing_zones    = false
  custom_landing_zones         = local.custom_landing_zones
  deploy_identity_resources    = true
  subscription_id_identity     = var.identity_subscription_id  
  configure_identity_resources = local.configure_identity_resources


  deploy_connectivity_resources = false
  subscription_id_connectivity  = var.connectivity_subscription_id

  deploy_management_resources   = false
  subscription_id_management    = var.management_subscription_id
}