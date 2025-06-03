resource_group_name = "rg-networking"
location            = "East US"
vnet_name           = "vnet-main"
vnet_address_space  = ["10.0.0.0/16"]

subnets = [
  {
    name             = "subnet-app"
    address_prefixes = ["10.0.1.0/24"]
    nsg_id           = "/subscriptions/xxxx/resourceGroups/rg-networking/providers/Microsoft.Network/networkSecurityGroups/nsg-app"
    route_table_id   = "/subscriptions/xxxx/resourceGroups/rg-networking/providers/Microsoft.Network/routeTables/rt-app"
  },
  {
    name             = "subnet-db"
    address_prefixes = ["10.0.2.0/24"]
    nsg_id           = null
    route_table_id   = null
  }
]
