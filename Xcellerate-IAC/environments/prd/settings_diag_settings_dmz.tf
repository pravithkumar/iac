locals {
  configure_diag_settings_dmz_resources = {

    settings = {

      "agw-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                           = "send-appgw-logs-to-law-mgmt-001"
        target_resource_id             = module.application_gateway["agw-${var.app_name}-${var.environment}-${var.location}-001"].id
        log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.this.id
        log_analytics_destination_type = "Dedicated"

        metric = [{
          category = "AllMetrics"
          enabled  = true
        }]

        enabled_log = [{
          category       = "ApplicationGatewayAccessLog"
          category_group = null
          },
          {
            category       = "ApplicationGatewayPerformanceLog"
            category_group = null
        }]
      }
    }
  }
}
