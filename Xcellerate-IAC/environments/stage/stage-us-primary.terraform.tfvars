### resource group configuration
rg1_resource_group_name = "rg-xl-stg-eastus-001"
rg1_location            = "eastus"
rg1_subscription_id     = "67f22aef-fb98-484d-b93a-fd24f9236c2c"

rg2_resource_group_name = "rg-network-xl-eastus-002"
rg2_location            = "eastus"
rg2_subscription_id     = "67f22aef-fb98-484d-b93a-fd24f9236c2c"

rg3_resource_group_name = "rg-xl-stg-eastus-001"
rg3_location            = "eastus"
rg3_subscription_id     = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"

### managed identity configuration
name = "mi-xl-stg-eastus-001"

tags = {
  ApplicationName    = "Xcellerate"
  BusinessUnit       = "Data&Tech:Xcellerate Management"
  CI                 = "TBD"
  CostCenter         = "TBD"
  Environment        = "STAGING"
  ITApplicationOwner = "Krishan Punia"
  ITCostOwner        = "Bryenton Troy"
}

### vnet configuration
vnet_name       = "vnet-xl-stg-eastus-001"
address_space   = ["10.48.20.0/22"]
subnet_prefixes = ["10.48.20.0/24", "10.48.21.0/24", "10.48.22.0/24"]
subnet_names    = ["snet-xl-stg-pe-001", "snet-xl-stg-aks-001", "snet-xl-stg-apim-001"]

location = "eastus"

environment = "stg"

app_name = "xl"

mssql_db_name = "XCELLERATE-STAGE"

### application gateway configuration
backend_address_fqdns = ["nextgen-xcellerate-stg01-eastus-api.cds.fortrea.com"]