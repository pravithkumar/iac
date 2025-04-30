output "spn_password_value" {
  description = "The generated service principal password"
  value       = random_password.spn_password.result
}

output "key_vault_secret_id" {
  description = "The ID of the Key Vault secret"
  value       = azurerm_key_vault_secret.example.id
}
