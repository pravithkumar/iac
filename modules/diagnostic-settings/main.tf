resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  count             =  var.enable_monitoring ? 1 : 0
  name               = var.monitor_diagnostic_name
  target_resource_id = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "WorkflowRuntime"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}