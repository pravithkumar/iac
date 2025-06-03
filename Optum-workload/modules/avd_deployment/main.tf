data "azurerm_resource_group" "rg" {
  name = "optum-chinmayee"
}

data "azurerm_virtual_network" "vnet" {
  name      = "chinmayeevnet"
  resource_group_name = "data.azurerm_resource_group.rg.name"
}

data "azurerm_subnet" "subnet" {
  name    = "chinmayeesubnet"
  virtual_network_name    = "data.azurerm_virtual_network.vnet.name"
  resource_group_name = "data.azurerm_resource_group.rg.name"

}