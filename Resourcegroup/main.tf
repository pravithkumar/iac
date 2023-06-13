# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "azurerm_resource_group" {
  source                 = "../Modules/resourcegroup"
   name                = var.name
  location             = var.location
  
}