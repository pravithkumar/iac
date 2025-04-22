output "id" {
  description = "The ID of the API Management Service."
  value       = azurerm_api_management.api.id
}

output "principal_id" {
  value = azurerm_api_management.api.identity[0].principal_id
}