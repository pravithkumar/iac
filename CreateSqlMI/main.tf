# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "SqlMI" {
  source                        = "../Modules/SqlMI"
  resource_group_name           = var.resource_group_name
  vnet_resource_group_name      = var.vnet_resource_group_name
  vnet_name                     = var.vnet_name
  subnet_name                   =var.subnet_name
  sqlmi_name                    =var.sqlmi_name
  administrator_login           =var.administrator_login
  administrator_login_password  =var.administrator_login_password
  license_type                  =var.license_type
  sku_name                      =var.sku_name
  vcores                        =var.vcores
  storage_size_in_gb            =var.storage_size_in_gb

}