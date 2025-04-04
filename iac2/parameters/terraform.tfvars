resource_groups = [
  { name = "rg-int-vnet-esu-005" },
  { name = "rg-int-dns-esu-006" },
  { name = "rg-int-apps-esu-007" }
]
location              = "East US"
vnet_name             = "vnet-int-dev-esu-002"
vnet_address_space    = ["10.1.0.0/16"]

subnets = [
  { name = "subnet1", address_prefixes = ["10.1.1.0/24"] },
  { name = "subnet2", address_prefixes = ["10.1.2.0/24"] },
  { name = "subnet3", address_prefixes = ["10.1.3.0/24"] }
]

private_dns_zones = [
  { name = "privatelink.apimanagement.azure-api.net" },
  { name = "privatelink.azure-api.net" },
  { name = "privatelink.azurewebsites.net" },
  { name = "privatelink.blob.core.windows.net" },
  { name = "privatelink.servicebus.windows.net" },
  { name = "privatelink.vaultcore.azure.net" }
]