provider "azurerm" {
  features {}
}

module "infrastructure" {
  source    = "../modules/rg-vnet-dns"
  providers = { azurerm = azurerm.integ-nprod-001 }

  resource_groups       = var.resource_groups
  location              = var.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  subnets               = var.subnets
  private_dns_zones     = var.private_dns_zones
}