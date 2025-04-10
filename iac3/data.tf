data "azurerm_subnet" "default_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "default"
  virtual_network_name = "vnet-fort-dev-eus-001"
  resource_group_name  = "rg-fort-dev-eus-004"
}


data "azurerm_subnet" "delegated_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "default2"
  virtual_network_name = "vnet-fort-dev-eus-001"
  resource_group_name  = "rg-fort-dev-eus-004"
}

data "azurerm_application_insights" "ai" {
  name                = "appinsights-int-esu-001"
  resource_group_name = "rg-int-apps-esu-003"
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
