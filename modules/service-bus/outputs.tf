output "servicebus_id" {
  value = azurerm_servicebus_namespace.servicebus.id 
}

output "principal_id" {
  value = azurerm_servicebus_namespace.servicebus.identity[0].principal_id
}