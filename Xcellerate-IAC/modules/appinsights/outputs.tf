output "id" {
  value       = azurerm_application_insights.this.id
  description = "The App Insights ID."
}

output "instrumentation_key" {
  description = "Created application_insights ID."
  value       = azurerm_application_insights.this.instrumentation_key
}
