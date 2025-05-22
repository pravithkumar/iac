locals {
  configure_diag_settings_resources = {

    settings = {

      "acr${var.app_name}${var.environment}${var.location}001" = {
        name                       = "send-acr-logs-to-law-mgmt-001"
        target_resource_id         = module.acr.acrxlprodeastus001.id   
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        # storage_account_id            = ""
        # eventhub_name                 = ""
        log_analytics_destination_type = "Dedicated"
        # eventhub_authorization_rule_id = ""
        # partner_solution_id            = ""

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
        target_resource_id         = module.redis_cache.redis-xl-prod-eastus-001.id
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        # storage_account_id            = ""
        # eventhub_name                 = ""
        log_analytics_destination_type = "Dedicated"
        # eventhub_authorization_rule_id = ""
        # partner_solution_id            = ""

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
      "aks-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-aks-logs-to-law-mgmt-001"
        target_resource_id         = module.aks.aks-xl-prod-eastus-001.id  
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        # storage_account_id            = ""
        # eventhub_name                 = ""
        log_analytics_destination_type = "Dedicated"
        # eventhub_authorization_rule_id = ""
        # partner_solution_id            = ""

        metric = [{
          category = "AllMetrics"
          enabled  = true
        }]

        enabled_log = [{
          category       = "kube-apiserver"
          category_group = null
          },
          {
            category       = "kube-controller-manager"
            category_group = null
          },
          {
            category       = "kube-scheduler"
            category_group = null
          },
          {
            category       = "cluster-autoscaler"
            category_group = null
          }
        ]
      }

      "apim-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-apim-logs-to-law-mgmt-001"
        target_resource_id         = module.apim.apim-xl-prod-eastus-001.id
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        # storage_account_id            = ""
        # eventhub_name                 = ""
        log_analytics_destination_type = "Dedicated"
        # eventhub_authorization_rule_id = ""
        # partner_solution_id            = ""

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
      } # "apim-${var.app_name}-${var.environment}-${var.location}-001" = {
      #   name                       = "send-apim-logs-to-law-mgmt-001"
      #   target_resource_id         = module.apim.apim-xl-prod-eastus-001.id
      #   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
      #   # storage_account_id            = ""
      #   # eventhub_name                 = ""
      #   log_analytics_destination_type = "Dedicated"
      #   # eventhub_authorization_rule_id = ""
      #   # partner_solution_id            = ""

      #   metric = [{
      #     category = "AllMetrics"
      #     enabled  = true
      #   }]

      #   enabled_log = [{
      #     category       = "GatewayLogs"
      #     category_group = null
      #     },
      #     {
      #       category       = "WebSocketConnectionLogs"
      #       category_group = null
      #     },
      #     {
      #       category       = "DeveloperPortalAuditLogs"
      #       category_group = null
      #     }
      #   ]
      # }
      "appi-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-appi-logs-to-law-mgmt-001"
        target_resource_id         = module.application_insights_prod.appi-xl-prod-eastus-001.id
        log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
        # storage_account_id            = ""
        # eventhub_name                 = ""
        log_analytics_destination_type = "Dedicated"
        # eventhub_authorization_rule_id = ""
        # partner_solution_id            = ""

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
      # "kv-${var.app_name}-${var.environment}-${var.location}-001" = {
      #   name                       = "send-keyvault-logs-to-law-mgmt-001"
      #   target_resource_id         = module.diag_settings_prod.kv-xl-prod-eastus-001.id  # "/subscriptions/1f85dc49-7d1b-4f8f-b83e-df5823315283/resourceGroups/rg-xl-prod-eastus-001/providers/Microsoft.KeyVault/vaults/kv-xl-prod-eastus-001"
      #   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id
      #   # storage_account_id            = ""
      #   # eventhub_name                 = ""
      #   log_analytics_destination_type = "Dedicated"
      #   # eventhub_authorization_rule_id = ""
      #   # partner_solution_id            = ""

      #   metric = [{
      #     category = "AllMetrics"
      #     enabled  = true
      #   }]

      #   enabled_log = [{
      #     category       = "AuditEvent"
      #     category_group = null
      #     },
      #     {
      #       category       = "AzurePolicyEvaluationDetails"
      #       category_group = null
      #   }]
      # }
    }
  }
}
