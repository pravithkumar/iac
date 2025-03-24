output "private_endpoint_name" {
  value = azurerm_private_endpoint.pe.name 
}

output "private_dns_name" {
  value = azurerm_private_endpoint.pe.private_dns_zone_group[0].name  
}