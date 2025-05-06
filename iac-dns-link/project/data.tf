data "azurerm_virtual_network" "example" {
  provider           = azurerm.integ-mgmt-001
  name                = "vnet-int-esu-002"
  resource_group_name = "rg-int-vnet-esu-003"
}