module "dns_zone_links" {
  providers            = { azurerm = integ-nprod-001 }
  source               = "../modules/dns_link"
  resource_group_name  = var.resource_group_name
  virtual_network_id   = data.azurerm_virtual_network.example.id
  dns_zones            = var.dns_zones
}

