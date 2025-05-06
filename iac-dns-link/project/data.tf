data "azurerm_virtual_network" "example" {
  provider            = azurerm.vnet
  name                = "vnet-int-dev-esu-001"
  resource_group_name = "rg-int-vnet-esu-001"
}