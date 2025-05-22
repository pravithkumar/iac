output "key_vault_secret_id" {
  description = "The ID of the Key Vault secret"
  value       = azurerm_key_vault_secret.this.id
}


output "app_kv_secret_name" {   
  value       = azurerm_key_vault_secret.this.name   
  description = "The name of the Key Vault secret." 
  }