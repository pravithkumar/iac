data "azurerm_client_config" "this" {}

data "azurerm_client_config" "current" {}

data "azurerm_log_analytics_workspace" "this" {
  provider            = azurerm.mgmt
  name                = "law-mgmt-01"
  resource_group_name = "rg-mgmt-prod-001"
}

data "azurerm_virtual_network" "vnet_applz" {
  provider            = azurerm.applz
  name                = "vnet-xl-dr-westus-001"
  resource_group_name = "rg-network-xl-westus-001"
}

data "azurerm_subnet" "snet_pe" {
  provider             = azurerm.applz
  name                 = "snet-xl-dr-pe-001"
  virtual_network_name = "vnet-xl-dr-westus-001"
  resource_group_name  = "rg-network-xl-westus-001"
}

data "azurerm_subnet" "snet_aks" {
  provider             = azurerm.applz
  name                 = "snet-xl-dr-aks-001"
  virtual_network_name = "vnet-xl-dr-westus-001"
  resource_group_name  = "rg-network-xl-westus-001"
}

data "azurerm_subnet" "snet_apim" {
  provider             = azurerm.applz
  name                 = "snet-xl-dr-apim-001"
  virtual_network_name = "vnet-xl-dr-westus-001"
  resource_group_name  = "rg-network-xl-westus-001"
}

data "azurerm_subnet" "snet_agw_dmz" {
  provider             = azurerm.dmz
  name                 = "snet-agw-xl-dr-001"
  virtual_network_name = "vnet-dmz-inet-westus-001"
  resource_group_name  = "rg-network-dmz-inet-westus-001"
}

data "azurerm_subnet" "snet_pe_dmz" {
  provider             = azurerm.dmz
  name                 = "snet-xl-dr-pe-001"
  virtual_network_name = "vnet-dmz-inet-westus-001"
  resource_group_name  = "rg-network-dmz-inet-westus-001"
}

data "azurerm_private_dns_zone" "privatelink_azurecr_io" {
  provider            = azurerm.shared_services
  name                = "privatelink.azurecr.io"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "privatelink_azmk8s_io" {
  provider            = azurerm.shared_services
  name                = "privatelink.eastus.azmk8s.io"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "privatelink_vaultcore_azure_net" {
  provider            = azurerm.shared_services
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "privatelink_redis_cache_windows_net" {
  provider            = azurerm.shared_services
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "privatelink_database_windows_net" {
  provider            = azurerm.shared_services
  name                = "privatelink.database.windows.net"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_private_dns_zone" "privatelink_blob_core_windows_net" {
  provider            = azurerm.shared_services
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = "rg-dns-prod-001"
}




