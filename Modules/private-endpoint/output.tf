output "private_endpoint_name" {
  value = azurerm_private_endpoint.acr_private_endpoint.name           
}

output "private_dns_name" {
  value = azurerm_private_dns_zone.acr_private_dns_zone.name              
}
