data "azurerm_resource_group" "rg" {
  name = var.existing_resource_group_name

  }

data "azurerm_virtual_network" "vnet" {
  name      = var.existing_virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "subnet" {
  name    = var.existing_subnet_name
  virtual_network_name    = data.azurerm_virtual_network.vnet.name
  resource_group_name = data.azurerm_resource_group.rg.name
}

#-----------Image Gallery