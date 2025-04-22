data "azurerm_subnet" "default_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "subnet1"
  virtual_network_name = "vnet-int-dev-eus-001"
  resource_group_name  = "rg-int-vnet-dev-eus-001"
}

data "azurerm_subnet" "fa_outbound_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "subnet3"
  virtual_network_name = "vnet-int-dev-eus-001"
  resource_group_name  = "rg-int-vnet-dev-eus-001"
}


data "azurerm_subnet" "delegated_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "subnet2"
  virtual_network_name = "vnet-int-dev-eus-001"
  resource_group_name  = "rg-int-vnet-dev-eus-001"
}

data "azurerm_application_insights" "ai" {
  provider            = azurerm.integ-nprod-001
  name                = "ai-int-dev-eus-001"
  resource_group_name = "rg-int-apps-dev-eus-003"
}

data "azurerm_private_dns_zone" "function_app_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "rg-int-dns-dev-eus-002"
}

data "azurerm_private_dns_zone" "servicebus_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "rg-int-dns-dev-eus-002"
}

data "azurerm_private_dns_zone" "key_vault_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-int-dns-dev-eus-002"
}

data "azurerm_private_dns_zone" "storageaccount1_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-int-dns-dev-eus-002"
}

data "azurerm_private_dns_zone" "storageaccount2_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-int-dns-dev-eus-002"
}

data "azurerm_private_dns_zone" "api_management_dns" {
  provider            = azurerm.integ-nprod-001
  name                = "privatelink.azure-api.net"
  resource_group_name = "rg-int-dns-dev-eus-002"
}

data "azurerm_log_analytics_workspace" "la" {
  provider            = azurerm.integ-nprod-001
  name                = "la-int-dev-eus-001"
  resource_group_name = "rg-int-apps-dev-eus-003"
}