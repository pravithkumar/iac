### resource group configuration
rg1_resource_group_name = "rg-xl-prod-eastus-001"
rg1_location            = "eastus"
rg1_subscription_id     = "1f85dc49-7d1b-4f8f-b83e-df5823315283"

rg2_resource_group_name = "rg-network-xl-eastus-001"
rg2_location            = "eastus"
rg2_subscription_id     = "1f85dc49-7d1b-4f8f-b83e-df5823315283"

rg3_resource_group_name = "rg-xl-prod-eastus-001"
rg3_location            = "eastus"
rg3_subscription_id     = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"

### managed identity configuration
identity_name = "mi-xl-prod-eastus-001"

tags = {
  ApplicationName    = "Xcellerate"
  BusinessUnit       = "Data&Tech:Xcellerate Management"
  CI                 = "TBD"
  CostCenter         = "TBD"
  Environment        = "PROD"
  ITApplicationOwner = "Krishan Punia"
  ITCostOwner        = "Bryenton Troy"
}

### vnet configuration
vnet_name       = "vnet-xl-prod-eastus-001"
address_space   = ["10.58.64.0/22"]
subnet_prefixes = ["10.58.64.0/24", "10.58.65.0/24", "10.58.66.0/24"]
subnet_names    = ["snet-xl-prod-pe-001", "snet-xl-prod-aks-001", "snet-xl-prod-apim-001"]

location = "eastus"

environment = "prod"

app_name = "xl"

