provider "azurerm" {
  features {}
}

module "infrastructure" {
  source = "./modules/private_dns_zone"
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  resource_group_1_name = var.resource_group_1_name
  resource_group_2_name = var.resource_group_2_name
  resource_group_3_name = var.resource_group_3_name
  location              = var.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  subnet_name           = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  private_dns_zones     = var.private_dns_zones
}
