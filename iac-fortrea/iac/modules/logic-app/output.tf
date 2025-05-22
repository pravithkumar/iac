output "id" {
  value = azurerm_logic_app_standard.logic_app.id
  description = "The ID of the Logic App Standard"
}
 
output "principal_id" {
  value = azurerm_logic_app_standard.logic_app.identity[0].principal_id
}