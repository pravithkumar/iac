resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  count             =  var.enable_monitor ? [1] : []
  name               = var.monitor_diagnostic_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  logs {
    category = "WorkflowRuntime"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  metrics {
    category = "AllMetrics"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}