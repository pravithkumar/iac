output "key_vault_secret_id" {
  description = "The ID of the Key Vault secret"
  value       = azurerm_key_vault_secret.example.id
}
