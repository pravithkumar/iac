resource_group_name = "rg-networking"
location            = "East US"
vnet_name           = "vnet-main"
vnet_address_space  = ["10.0.0.0/16"]

subnets = [
  {
    name             = "subnet-app"
    address_prefixes = ["10.0.1.0/24"]
    nsg_id           = null
    route_table_id   = null
  },
  {
    name             = "subnet-db"
    address_prefixes = ["10.0.2.0/24"]
    nsg_id           = null
    route_table_id   = null
  }
]
