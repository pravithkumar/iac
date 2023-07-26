# Configure the Microsoft Azure Provider
provider "cname_records" {
  features {}
}

module "Vnet" {
  source                 = "../Modules/CName"
  name                = var.name
  address_space       = ["192.168.2.16/28"]
  location            = var.location
  resource_group_name = var.resource_group_name
}