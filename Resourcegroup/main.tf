# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "dns_Arecord" {
  source                 = "../Modules/Compute/Arecord"
   name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name 
  record_ip            = var.record_ip
  
}