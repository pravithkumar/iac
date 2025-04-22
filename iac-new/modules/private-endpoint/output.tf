output "private_endpoint_id" {
  value = azurerm_private_endpoint.pe.id
}

output "private_service_connection_id" {
  value = azurerm_private_endpoint.pe.private_service_connection[0].private_connection_resource_id
}

output "private_dns_zone_group_id" {
  value = azurerm_private_endpoint.pe.private_dns_zone_group[0].id
}