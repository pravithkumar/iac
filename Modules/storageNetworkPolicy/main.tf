# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "storageNetworkPolicy" {
  source                 = "../Modules/Storage/storageaccountnetworkpolicy"
  resource_group_name    = var.resource_group_name
  storageAccountName     = var.storageAccountName
  defalutaction          = var.defalutaction  
  subnetid               = var.subnetid  
}