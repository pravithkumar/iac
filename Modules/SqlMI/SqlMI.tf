resource "azurerm_resource_group" "example" {
  name     = "rg-example"
  location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
  name                = "test-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "acctsub"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_sql_managed_instance" "example" {
  name                         = "example"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = azurerm_resource_group.example.location
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"
  license_type                 = "BasePrice"
  subnet_id                    = azurerm_subnet.example.id
  sku_name                     = "GP_Gen5"
  vcores                       = 4
  storage_size_in_gb           = 32
}

resource "azurerm_sql_managed_database" "example" {
  sql_managed_instance_id = azurerm_sql_managed_instance.example.id
  name                    = "exampledatabase"
  location                = azurerm_resource_group.example.location
}