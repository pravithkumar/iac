output "id" {
  description = "The Resource ID of the Azure Cache for Redis."
  value       = azurerm_redis_cache.this.id
}
 
output "name" {
  description = "The Azure Cache for Redis instance's host name in the format: `<name>.redis.cache.windows.net`."
  value       = azurerm_redis_cache.this.name
}