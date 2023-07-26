resource "azurerm_private_dns_cname_record" "cname_records" {
  name                = var.name
  record              = var.record
  resource_group_name = var.resource_group_name
  tags                = var.tags
  ttl                 = var.ttl