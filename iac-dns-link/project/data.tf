data "azurerm_virtual_network" "example" {
  provider           = { azurerm = integ-nprod-001 }
  name                = "vnet-int-dev-esu-001"
  resource_group_name = "rg-int-vnet-esu-001"
}