output "id" {
  value = azurerm_user_assigned_identity.mid.id
}

output "principal_id" {
  description = "Principal ID for user assigned identity"
  value       = azurerm_user_assigned_identity.mid.principal_id
}