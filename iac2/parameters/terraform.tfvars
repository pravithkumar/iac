resource_group_1_name = "rg-vnet"
resource_group_2_name = "rg-dns"
resource_group_3_name = "rg-empty"
location              = "East US"
vnet_name             = "my-vnet"
vnet_address_space    = ["10.0.0.0/16"]
subnet_name           = "my-subnet"
subnet_address_prefixes = ["10.0.1.0/24"]

private_dns_zones = [
  { name = "privatednszone-stg.com" },
  { name = "privatednszone-fnapp.com" },
  { name = "privatednszone-ase.com" },
  { name = "privatednszone-kv.com" },
  { name = "privatednszone-db.com" },
  { name = "privatednszone-web.com" },
  { name = "privatednszone-api.com" },
  { name = "privatednszone-cache.com" }
]
