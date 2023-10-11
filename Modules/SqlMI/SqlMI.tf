data "azurerm_resource_group" "example" {
  name     = var.resource_group_name  
}

data "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_virtual_network.example.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.example.name  
}

resource "azurerm_mssql_managed_instance" "example" {
  name                         = var.sqlmi_name
  resource_group_name          = data.azurerm_resource_group.example.name
  location                     = data.azurerm_resource_group.example.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  license_type                 = var.license_type
  subnet_id                    = data.azurerm_subnet.example.id
  sku_name                     = var.sku_name
  vcores                       = var.vcores
  storage_size_in_gb           = var.storage_size_in_gb
}

resource "azurerm_mssql_managed_database" "example" {
  managed_instance_id = azurerm_mssql_managed_instance.example.id
  name                    = var.dbname
  
}