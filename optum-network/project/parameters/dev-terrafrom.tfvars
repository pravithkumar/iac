resource_group_name = "rg-fortrea-delete-01"
location            = "East US"
vnet_name           = "vnet-main"
vnet_address_space  = ["10.0.0.0/16"]

subnets = [
  {
    name             = "subnet-app"
    address_prefixes = ["10.0.1.0/24"]
    nsg_id           = null
    route_table_id   = null
    delegations      = null
  },
  {
    name             = "subnet-db"
    address_prefixes = ["10.0.2.0/24"]
    nsg_id           = null
    route_table_id   = null
    delegations = [
      {
        name         = "delegation1"
        service_name = "Microsoft.Web/serverFarms"
        actions      = ["Microsoft.Network/virtualNetworks/subnets/action"]
      }
    ]
  }
]
