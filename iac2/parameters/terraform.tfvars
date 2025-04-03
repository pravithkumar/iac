resource_group_1_name = "rg-int-vnet-esu-001"
resource_group_2_name = "rg-int-dns-esu-002"
resource_group_3_name = "rg-int-apps-esu-003"
location              = "East US"
vnet_name             = "vnet-int-dev-esu-001"
vnet_address_space    = ["10.0.0.0/16"]

subnets = [
  { name = "subnet1", address_prefixes = ["10.0.1.0/24"] },
  { name = "subnet2", address_prefixes = ["10.0.2.0/24"] },
  { name = "subnet3", address_prefixes = ["10.0.3.0/24"] }
]

private_dns_zones = [
  "1" = { name = "privatelink.apimanagement.azure-api.net" },
  "2" = { name = "privatelink.azure-api.net" },
  "3" = { name = "privatelink.azurewebsites.net" },
  "4" = { name = "privatelink.blob.core.windows.net" },
  "5" = { name = "privatelink.servicebus.windows.net" },
  "6" = { name = "privatelink.vaultcore.azure.net" }
]