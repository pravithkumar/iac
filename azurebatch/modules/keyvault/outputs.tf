output "key_vault_id" {
  description = "The ID of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "vault_url" {
  description = "The URI of the Key Vault"
  value       = azurerm_key_vault.keyvault.vault_uri
}
