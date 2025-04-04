resource "azurerm_application_insights" "appins" {
  name                = var.appinsights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = var.workspace_id
  application_type    = var.application_type
  retention_in_days   = var.retention_in_days != null ? var.retention_in_days : null
  tags                = var.tags
}