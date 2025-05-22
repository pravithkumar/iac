resource "azurerm_private_dns_a_record" "this" {
  name                = var.record_name
  zone_name           = var.zone_name
  resource_group_name = var.dns_zone_resource_group
  ttl                 = var.ttl
  records             = var.ip_addresses
}