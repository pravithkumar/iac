data "azurerm_subnet" "default_subnet" {
  provider             = azurerm.integ-mgmt-001
  name                 = "subnet1"
  virtual_network_name = "vnet-int-dev-esu-001"
  resource_group_name  = "rg-int-vnet-esu-001"
}

data "azurerm_private_dns_zone" "function_app_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "rg-int-dns-esu-002"
}

data "azurerm_private_dns_zone" "servicebus_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "rg-int-dns-esu-002"
}

data "azurerm_private_dns_zone" "key_vault_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-int-dns-esu-002"
}

data "azurerm_private_dns_zone" "storageaccount1_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-int-dns-esu-002"
}

data "azurerm_private_dns_zone" "storageaccount2_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-int-dns-esu-002"
}

data "azurerm_private_dns_zone" "api_management_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.azure-api.net"
  resource_group_name = "rg-int-dns-esu-002"
}
