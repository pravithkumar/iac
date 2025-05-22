output "id" {
  value = azurerm_app_service_environment_v3.ase.id
}

output "internal_ip" {
  value = azurerm_app_service_environment_v3.ase.internal_inbound_ip_addresses
}
