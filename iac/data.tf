data "azurerm_subnet" "default_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "default"
  virtual_network_name = "vnet-fortrea-01"
  resource_group_name  = "rg-fortrea-delete-01"
}

data "azurerm_private_dns_zone" "function_app_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "rg-fortrea-delete-01"
}

data "azurerm_private_dns_zone" "servicebus_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "rg-fortrea-delete-01"
}

data "azurerm_private_dns_zone" "key_vault_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-fortrea-delete-01"
}

data "azurerm_private_dns_zone" "storageaccount1_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-fortrea-delete-01"
}

data "azurerm_private_dns_zone" "storageaccount2_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-fortrea-delete-01"
}
