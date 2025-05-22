data "azurerm_subnet" "default_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "snet-ns-pe-001"
  virtual_network_name = "vnet-integ-nprod-eastus-001"
  resource_group_name  = "rg-network-integ-nprod-eus-001"
}

data "azurerm_subnet" "apim_pe_subnet" {
  provider             = azurerm.dmz
  name                 = "snet-apim-azureintegration-eus-001"
  virtual_network_name = "vnet-dmz-inet-eastus-001"
  resource_group_name  = "rg-network-dmz-inet-eastus-001"
}

data "azurerm_subnet" "delegated_subnet" {
  provider             = azurerm.integ-nprod-001
  name                 = "snet-ns-apps-001"
  virtual_network_name = "vnet-integ-nprod-eastus-001"
  resource_group_name  = "rg-network-integ-nprod-eus-001"
}

data "azurerm_virtual_network" "intvnet" {
  provider           = azurerm.integ-nprod-001
  name                = "vnet-integ-nprod-eastus-001"
  resource_group_name = "rg-network-integ-nprod-eus-001"
}

data "azurerm_virtual_network" "dmzvnet" {
  provider             = azurerm.dmz
  name                = "vnet-dmz-inet-eastus-001"
  resource_group_name = "rg-network-dmz-inet-eastus-001"
}

data "azurerm_application_insights" "ai" {
  provider            = azurerm.integ-nprod-001
  name                = local.appinsights_name
  resource_group_name = local.resource_group_name
  depends_on          = [module.app_insight]
}

data "azurerm_private_dns_zone" "servicebus_dns" {
  provider            = azurerm.shared-dns
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "key_vault_dns" {
  provider            = azurerm.shared-dns
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "storageaccount1_dns" {
  provider            = azurerm.shared-dns
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "storageaccount2_dns" {
  provider            = azurerm.shared-dns
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "api_management_dns" {
  provider            = azurerm.shared-dns
  name                = "privatelink.azure-api.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "api_management" {
  provider            = azurerm.shared-dns
  name                = "azure-api.net"
  resource_group_name = "rg-dns-prod-001"
}

// data "azurerm_private_dns_zone" "appservice" {
//   provider            = azurerm.shared-dns
//   name                = "appserviceenvironment.net"
//   resource_group_name = "rg-dns-prod-001"
// }

data "azurerm_log_analytics_workspace" "la" {
  provider            = azurerm.mgmt
  name                = "law-mgmt-01"
  resource_group_name = "rg-mgmt-prod-001"
}

// data "azurerm_key_vault_secret" "spn_password" {
//   provider             = azurerm.dmz
//   name                 = module.spn_password.app_kv_secret_name
//   key_vault_id         = module.azurerm_key_vault.key_vault_id
// }

