locals {
  configure_ai_resources = {
    settings = {
      "appi-${var.app_name}-${var.environment}-${var.location}-001" = {
        resource_group_name        = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        name                       = "appi-${var.app_name}-${var.environment}-${var.location}-001"
        location                   = var.location
        application_type           = "web"
        workspace_id               = data.azurerm_log_analytics_workspace.this.id
        internet_ingestion_enabled = false
        internet_query_enabled     = true
      }
    }
  }
}
