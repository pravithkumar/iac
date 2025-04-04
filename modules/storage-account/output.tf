output "id" {
  value = azurerm_storage_account.sa.id
}
output "primary_access_key" {
  value     = azurerm_storage_account.sa.primary_access_key
  sensitive = true
  description = "The primary access key for the storage account."
}