resource "azurerm_role_assignment" "this" {
  name                 = var.settings.name
  scope                = var.settings.scope
  role_definition_name = var.settings.role_definition_name
  principal_id         = var.settings.principal_id
  lifecycle {
    ignore_changes = [
      principal_id,
      role_definition_name
    ]
  }
}
