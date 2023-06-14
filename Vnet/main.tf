# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "Vnet" {
  source                 = "../Modules/Compute/Vnet"
  name                = var.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}
  
