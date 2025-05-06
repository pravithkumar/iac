resource "azurerm_private_dns_zone_virtual_network_link" "example" {  
  for_each              = var.dns_zones
  name                  = each.key
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = each.value
  virtual_network_id    = var.virtual_network_id 
}

