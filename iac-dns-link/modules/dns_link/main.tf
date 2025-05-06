variable "resource_group_name" {
  type    = string
  default = "your-resource-group-name"
}

variable "vnet_name" {
  type    = string
  default = "your-existing-vnet-name"
}

variable "dns_zones" {
  type    = map(string)
  default = {
    "example1-link" = "your-existing-dns-zone1"
    "example2-link" = "your-existing-dns-zone2"
  }
}

data "azurerm_virtual_network" "example" {
  provider            = azurerm.vnet
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  provider              = azurerm.dns
  for_each              = var.dns_zones
  name                  = each.key
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = each.value
  virtual_network_id    = data.azurerm_virtual_network.example.id
}

