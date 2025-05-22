locals {
  configure_diag_settings_resources = {

    settings = {

      "acr${var.app_name}${var.environment}${var.location}001" = {
        name                       = "send-acr-logs-to-law-mgmt-001"
        target_resource_id         = module.acr["acr${var.app_name}${var.environment}${var.location}001"].id   
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        log_analytics_destination_type = "Dedicated"

        metric = [{
          category = "AllMetrics"
          enabled  = true
        }]

        enabled_log = [{
          category       = "ContainerRegistryLoginEvents"
          category_group = null
          },
          {
            category       = "ContainerRegistryRepositoryEvents"
            category_group = null
        }]
      }

      "redis-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-redis-logs-to-law-mgmt-001"
        target_resource_id         = module.redis_cache["redis-${var.app_name}-${var.environment}-${var.location}-001"].id
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        log_analytics_destination_type = "Dedicated"

        metric = [{
          category = "AllMetrics"
          enabled  = true
        }]

        enabled_log = [{
          category       = "ConnectedClientList"
          category_group = null
          },
          {
            category       = "MSEntraAuthenticationAuditLog"
            category_group = null
          }
        ]
      }
      
      "apim-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-apim-logs-to-law-mgmt-001"
        target_resource_id         = module.apim["apim-${var.app_name}-${var.environment}-${var.location}-001"].id
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        log_analytics_destination_type = "Dedicated"

        metric = [{
          category = "AllMetrics"
          enabled  = true
        }]

        enabled_log = [{
          category       = "GatewayLogs"
          category_group = null
          },
          {
            category       = "WebSocketConnectionLogs"
            category_group = null
          },
          {
            category       = "DeveloperPortalAuditLogs"
            category_group = null
          }
        ]
      }

      "appi-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-appi-logs-to-law-mgmt-001"
        target_resource_id         = module.application_insights_prod["appi-${var.app_name}-${var.environment}-${var.location}-001"].id
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        log_analytics_destination_type = "Dedicated"

        metric = [{
          category = "AllMetrics"
          enabled  = true
        }]

        enabled_log = [{
          category       = "AppAvailabilityResults"
          category_group = null
          },
          {
            category       = "AppBrowserTimings"
            category_group = null
          },
          {
            category       = "AppEvents"
            category_group = null
          },
          {
            category       = "AppMetrics"
            category_group = null
          },
          {
            category       = "AppDependencies"
            category_group = null
          },
          {
            category       = "AppExceptions"
            category_group = null
          },
          {
            category       = "AppPageViews"
            category_group = null
          },
          {
            category       = "AppPerformanceCounters"
            category_group = null
          },
          {
            category       = "AppRequests"
            category_group = null
          },
          {
            category       = "AppSystemEvents"
            category_group = null
          },
          {
            category       = "AppTraces"
            category_group = null
          }
        ]
      }
    }
  }
}
