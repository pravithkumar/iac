output "name" {
  description = "The name of the key vault certificate"
  value       = azurerm_key_vault_certificate.kv_certificate.name
}

output "id" {
  description = "The id of the key vault certificate"
  value       = azurerm_key_vault_certificate.kv_certificate.id
}