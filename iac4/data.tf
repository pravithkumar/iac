data "azurerm_subnet" "default_subnet" {
  provider             = azurerm.integ-mgmt-001
  name                 = "subnet1"
  virtual_network_name = "vnet-int-dev-esu-001"
  resource_group_name  = "rg-int-vnet-esu-001"
}


data "azurerm_subnet" "delegated_subnet" {
  provider             = azurerm.integ-mgmt-001
  name                 = "subnet2"
  virtual_network_name = "vnet-int-dev-esu-001"
  resource_group_name  = "rg-int-vnet-esu-001"
}



data "azurerm_private_dns_zone" "key_vault_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-int-dns-esu-002"
}

