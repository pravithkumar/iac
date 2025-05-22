data "azurerm_client_config" "this" {}

# data "azurerm_api_management" "this" {
#   name                = "apim-xl-prod-eastus-001"
#   resource_group_name = "rg-xl-prod-eastus-001"
# }

data "azurerm_client_config" "current" {}

data "azurerm_log_analytics_workspace" "this" {
  provider            = azurerm.mgmt
  name                = "law-mgmt-01"
  resource_group_name = "rg-mgmt-prod-001"
}
# data "azurerm_redis_cache" "this" {
#   name                = "redis-xl-prod-eastus-001"
#   resource_group_name = "rg-xl-prod-eastus-001"
# }

# resource "null_resource" "import_existing" {
#   provider = azurerm.prod
#   provisioner "local-exec" {
#     command = "'terraform import module.apim[\"apim-xl-prod-eastus-001\"].azurerm_api_management.this /subscriptions/1f85dc49-7d1b-4f8f-b83e-df5823315283/resourceGroups/rg-xl-prod-eastus-001/providers/Microsoft.ApiManagement/service/apim-xl-prod-eastus-001'"
#     #command = "terraform import module.apim[apim-xl-prod-eastus-001].azurerm_api_management.this ${data.azurerm_api_management.this.id}"
#     #command = "terraform import module.apim[\"apim-xl-prod-eastus-001\"].azurerm_api_management.this ${data.azurerm_api_management.this.id}"
#     # when    = data.azurerm_api_management.this.id != "" ? "create" : "never"
#   }
# }

# resource "null_resource" "import_existing1" {
#   provisioner "local-exec" {
#     command = "'terraform import module.apim[\"apim-xl-prod-eastus-001\"].azurerm_api_management.this' /subscriptions/1f85dc49-7d1b-4f8f-b83e-df5823315283/resourceGroups/rg-xl-prod-eastus-001/providers/Microsoft.ApiManagement/service/apim-xl-prod-eastus-001"
#   }
# }
# import {
#   id = "/subscriptions/1f85dc49-7d1b-4f8f-b83e-df5823315283/resourceGroups/rg-xl-prod-eastus-001/providers/Microsoft.ApiManagement/service/apim-xl-prod-eastus-001"
#   to = module.apim["apim-xl-prod-eastus-001"].azurerm_api_management.this
# }


# import {
#   id = "/subscriptions/1f85dc49-7d1b-4f8f-b83e-df5823315283/resourceGroups/rg-xl-prod-eastus-001/providers/Microsoft.Cache/redis/redis-xl-prod-eastus-001"
#   to = module.redis_cache["redis-xl-prod-eastus-001"].azurerm_redis_cache.this
# }

# import {
#   id = "/subscriptions/1f85dc49-7d1b-4f8f-b83e-df5823315283/resourceGroups/rg-network-xl-eastus-001/providers/Microsoft.Network/networkSecurityGroups/nsg-snet-xl-prod-apim-001"
#   to = module.network_security_group_prod["nsg-snet-xl-prod-apim-001"].azurerm_network_security_group.this
# }

data "azurerm_subnet" "snet_xl_prod_pe_001" {
  provider             = azurerm.prod
  name                 = "snet-xl-prod-pe-001"
  virtual_network_name = "vnet-xl-prod-eastus-001"
  resource_group_name  = "rg-network-xl-eastus-001"
}

data "azurerm_private_dns_zone" "privatelink_azurecr_io" {
  provider            = azurerm.shared_services
  name                = "privatelink.azurecr.io"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_user_assigned_identity" "mi_xl_prod_location_001" {
  provider            = azurerm.prod
  name                = "mi-xl-prod-eastus-001"
  resource_group_name = "rg-xl-prod-eastus-001"
}

data "azurerm_private_dns_zone" "privatelink_eastus_azmk8s_io" {
  provider            = azurerm.shared_services
  name                = "privatelink.eastus.azmk8s.io"
  resource_group_name = "rg-dns-prod-001"
}

data "azurerm_subnet" "snet_xl_prod_aks_001" {
  provider             = azurerm.prod
  name                 = "snet-xl-prod-aks-001"
  virtual_network_name = "vnet-xl-prod-eastus-001"
  resource_group_name  = "rg-network-xl-eastus-001"
}

data "azurerm_subnet" "snet_xl_prod_apim_001" {
  provider             = azurerm.prod
  name                 = "snet-xl-prod-apim-001"
  virtual_network_name = "vnet-xl-prod-eastus-001"
  resource_group_name  = "rg-network-xl-eastus-001"
}

data "azurerm_subnet" "snet_agw_xl_prod_001" {
  provider             = azurerm.dmz
  name                 = "snet-agw-xl-prod-001"
  virtual_network_name = "vnet-dmz-inet-eastus-001"
  resource_group_name  = "rg-network-dmz-inet-eastus-001"
}

data "azurerm_subnet" "dmz-snet-xl-prod-pe-001" {
  provider             = azurerm.dmz
  name                 = "snet-xl-prod-pe-001"
  virtual_network_name = "vnet-dmz-inet-eastus-001"
  resource_group_name  = "rg-network-dmz-inet-eastus-001"
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

data "azurerm_virtual_network" "vnet_xl_prod_location_001" {
  provider            = azurerm.prod
  name                = "vnet-xl-prod-eastus-001"
  resource_group_name = "rg-network-xl-eastus-001"
}

data "azurerm_monitor_data_collection_endpoint" "dce_ampls_centralized_eastus_001" {
  provider            = azurerm.mgmt
  name                = "dce-ampls-centralized-eastus-001"
  resource_group_name = "rg-mgmt-prod-001"
}
data "azurerm_kubernetes_cluster" "aks_xl_prod_eastus_001" {
  provider            = azurerm.prod
  name                = "aks-xl-prod-eastus-001"
  resource_group_name = "rg-xl-prod-eastus-001"
}




