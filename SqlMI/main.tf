# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "SqlMI" {
  source                 = "../Modules/SqlMI"
  resource_group_name    = var.resource_group_name
  vnet_resource_group_name    = var.vnet_resource_group_name

}