### resource group configuration
rg1_resource_group_name = "rg-xl-dr-westus-001"
rg1_location            = "westus"
rg1_subscription_id     = "1f85dc49-7d1b-4f8f-b83e-df5823315283"

rg2_resource_group_name = "rg-network-xl-westus-001"
rg2_location            = "westus"
rg2_subscription_id     = "1f85dc49-7d1b-4f8f-b83e-df5823315283"

rg3_resource_group_name = "rg-xl-dr-westus-001"
rg3_location            = "westus"
rg3_subscription_id     = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"

### managed identity configuration
name = "mi-xl-dr-westus-001"

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
vnet_name       = "vnet-xl-dr-westus-001"
address_space   = ["10.58.136.0/22"]
subnet_prefixes = ["10.58.136.0/24", "10.58.137.0/24", "10.58.138.0/24"]
subnet_names    = ["snet-xl-dr-pe-001", "snet-xl-dr-aks-001", "snet-xl-dr-apim-001"]

location = "westus"

environment = "dr"

app_name = "xl"

mssql_db_name = "XCELLERATE-DR"

### application gateway configuration
backend_address_fqdns = ["nextgen-xcellerate-dr01-westus-api.cds.fortrea.com"]