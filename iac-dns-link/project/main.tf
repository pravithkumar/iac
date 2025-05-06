module "dns_zone_links" {
  providers            = { azurerm = azurerm.dns }
  source               = "../modules/dns_zone_links"
  resource_group_name  = var.resource_group_name
  vnet_id              = data.azurerm_virtual_network.example.id
  dns_zones            = var.dns_zones
}

