output "id" {
  value = azurerm_app_service_environment_v3.ase.id
}

output "principal_id" {
  value = azurerm_app_service_environment_v3.ase.identity[0].principal_id
}