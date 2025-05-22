resource "azurerm_application_insights" "this" {
  name                       = var.settings.name
  location                   = var.settings.location
  resource_group_name        = var.settings.resource_group_name
  application_type           = var.settings.application_type
  workspace_id               = var.settings.workspace_id
  internet_ingestion_enabled = var.settings.internet_ingestion_enabled
  internet_query_enabled     = var.settings.internet_query_enabled
  tags                       = var.settings.tags
  lifecycle {
    ignore_changes = [tags]
  }
}
