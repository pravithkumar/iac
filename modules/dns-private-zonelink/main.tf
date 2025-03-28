resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                = var.virtual_network_link_name
  resource_group_name = var.resource_group_name
  private_dns_zone_id = var.dns_zone_id
  virtual_network_id  = var.virtual_network_id
}