data "azurerm_virtual_network" "example" {
  provider            = azurerm.vnet
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}