locals {
  configure_diag_settings_dmz_resources = {

    settings = {

      # "kv-${var.app_name}-dmz-${var.location}-001" = {
      #   name                       = "send-keyvault-logs-to-law-mgmt-001"
      #   target_resource_id         = "/subscriptions/d5fbc7cc-9748-4dfd-9de6-4915eed83bd0/resourceGroups/rg-xl-prod-eastus-001/providers/Microsoft.KeyVault/vaults/kv-xl-dmz-eastus-001"
      #   log_analytics_workspace_id = data.azurerm_log_analytics_workspace.this.id #"/subscriptions/87bd9787-7ec0-451d-aa1e-aa20f168e3ed/resourcegroups/rg-mgmt-prod-001/providers/microsoft.operationalinsights/workspaces/law-mgmt-01"
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
      "agw-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-appgw-logs-to-law-mgmt-001"
        target_resource_id         = module.application_gateway.agw-xl-prod-eastus-001.id
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
          category       = "ApplicationGatewayAccessLog"
          category_group = null
          },
          {
            category       = "ApplicationGatewayPerformanceLog"
            category_group = null
        }]
      }
      "afd-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "send-frontdoor-logs-to-law-mgmt-001"
        target_resource_id         = module.frontdoor.afd-xl-prod-eastus-001.frontdoor_id
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
          category       = "FrontDoorAccessLog"
          category_group = null
          },
          {
            category       = "FrontDoorHealthProbeLog"
            category_group = null
          },
          {
            category       = "FrontDoorWebApplicationFirewallLog"
            category_group = null
          }
        ]
      }
    }
  }
}
