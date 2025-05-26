data "azurerm_client_config" "current" {}

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "5.1.0"
  default_location = var.management_resources_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

# Base module configuration settings
  disable_telemetry              = true
  root_parent_id                 = data.azurerm_client_config.current.tenant_id
  root_id                        = var.root_id
  deploy_core_landing_zones      = false
#
  deploy_management_resources    = var.deploy_management_resources
  subscription_id_management     = var.management_subscription_id
  configure_management_resources = local.configure_management_resources
}
