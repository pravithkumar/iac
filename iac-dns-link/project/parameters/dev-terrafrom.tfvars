resource_group_name = "rg-int-dns-esu-002"
vnet_name           = "your-existing-vnet-name"
dns_zones = {
  "example1-link" = "privatelink.azure-api.net"
  "example2-link" = "privatelink.azurewebsites.net"
}
