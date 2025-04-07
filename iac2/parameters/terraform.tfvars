resource_groups = [
  { name = "rg-int-vnet-esu-001" },
  { name = "rg-int-dns-esu-002" },
  { name = "rg-int-apps-esu-003" }
]
location              = "East US"
vnet_name             = "vnet-int-dev-esu-001"
vnet_address_space    = ["10.0.0.0/16"]

subnets = [
  { name = "subnet1", address_prefixes = ["10.0.1.0/24"] },
  { name = "subnet2", address_prefixes = ["10.0.2.0/24"] },
  { name = "subnet3", address_prefixes = ["10.0.3.0/24"] }
]

private_dns_zones = [
  { name = "privatelink.apimanagement.azure-api.net" },
  { name = "privatelink.azure-api.net" },
  { name = "privatelink.azurewebsites.net" },
  { name = "privatelink.blob.core.windows.net" },
  { name = "privatelink.servicebus.windows.net" },
  { name = "privatelink.vaultcore.azure.net" }
]

loganalytics = {
  name                 = "law-int-esu-001"
  resource_group_name  = "rg-int-apps-esu-003"
  sku                  = "PerGB2018"
  identity             = null
}

appinsights = {
  name                 = "appinsights-int-esu-001"
  resource_group_name  = "rg-int-apps-esu-003"
  application_type     = "web"
}