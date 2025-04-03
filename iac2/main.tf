provider "azurerm" {
  features {}
}

module "infrastructure" {
  source = "../modules/rg-vnet-dns"
  providers = { azurerm = azurerm.integ-nprod-001 }
  resource_group_1_name = var.resource_group_1_name
  resource_group_2_name = var.resource_group_2_name
  resource_group_3_name = var.resource_group_3_name
  location              = var.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  subnet_name               = var.subnets
  private_dns_zones     = var.private_dns_zones
}
