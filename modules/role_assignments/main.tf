resource "azurerm_role_assignment" "example" {
  scope                = var.scope
  role_definition_name = "Reader"
  principal_id         = var.principal_id
}