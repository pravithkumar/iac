output "acr_id" {
  description = "The Container Registry ID."
  value       = azurerm_container_registry.this.id
}

output "id" {
  description = "The Container Registry ID."
  value       = azurerm_container_registry.this.id
}
 
 
output "login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.this.login_server
}
 
output "admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.this.admin_username
}
 
output "admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.this.admin_password
  sensitive   = true
}