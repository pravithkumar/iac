data "azurerm_client_config" "current" {}

module "enterprise_scale" {
  source  = "Azure/caf-enterprise-scale/azurerm"
  version = "5.2.0"
  default_location = var.connectivity_resources_location

  providers = {
    azurerm              = azurerm
    azurerm.connectivity = azurerm
    azurerm.management   = azurerm
  }

# Base module configuration settings
  root_parent_id                     = data.azurerm_client_config.current.tenant_id
  root_id                            = var.root_id

  deploy_core_landing_zones          = false
  deploy_connectivity_resources      = var.deploy_connectivity_resources
  subscription_id_connectivity       = var.connectivity_subscription_id
  configure_connectivity_resources   = local.configure_connectivity_resources
}

##############################end#########################
## Local Network Gateway configuration settings

resource "azurerm_local_network_gateway" "main" {
  count                = var.deploy_local_network_gateway ? 1 : 0
  name                 = local.lgw_gateway_name
  resource_group_name  = local.resource_group_name
  location             = local.location
  gateway_address      = local.lgw_gateway_address
  address_space        = local.lgw_address_space
  tags                 = var.tags
  depends_on = [module.enterprise_scale ]
}
