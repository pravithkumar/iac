# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "cname_records" {
  source                 = "../Modules/CName"
  name                = var.name
  record              = var.record
  resource_group_name = var.resource_group_name
  zone_name           = var.zone_name  
  ttl                 = var.ttl
}