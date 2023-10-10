data "azurerm_resource_group" "example" {
  name     = var.resource_group_name  
}

data "azurerm_virtual_network" "example" {
  name                = "vnet-pega-uat-eu-001" 
  resource_group_name = var.vnet_resource_group_name
}

data "azurerm_subnet" "example" {
  name                 = "subnet-pega-mi-001"
  resource_group_name  = data.azurerm_virtual_network.example.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.example.name  
}

resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

resource "azurerm_mssql_managed_instance" "example" {
  name                         = "sqlmi-pega-uat-eu-002"
  resource_group_name          = data.azurerm_resource_group.example.name
  location                     = data.azurerm_resource_group.example.location
  administrator_login          = "mradministrator"
  administrator_login_password = random_password.password.result
  license_type                 = "BasePrice"
  subnet_id                    = data.azurerm_subnet.example.id
  sku_name                     = "GP_Gen5"
  vcores                       = 4
  storage_size_in_gb           = 32
}

resource "azurerm_mssql_managed_database" "example" {
  managed_instance_id = azurerm_mssql_managed_instance.example.id
  name                    = "sqldb-pega-uat-eu-001"
  
}