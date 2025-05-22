resource "azurerm_monitor_diagnostic_setting" "this" {
  name                           = var.settings.name
  target_resource_id             = var.settings.target_resource_id
  log_analytics_workspace_id     = var.settings.log_analytics_workspace_id
  storage_account_id             = var.settings.storage_account_id
  eventhub_name                  = var.settings.eventhub_name
  log_analytics_destination_type = var.settings.log_analytics_destination_type
  eventhub_authorization_rule_id = var.settings.eventhub_authorization_rule_id
  partner_solution_id            = var.settings.partner_solution_id

  dynamic "metric" {
    for_each = var.settings.metric != null ? var.settings.metric : []
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
    }
  }

  dynamic "enabled_log" {
    for_each = var.settings.enabled_log != null ? var.settings.enabled_log : []
    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group
    }
  }
  lifecycle {
    ignore_changes = [
      metric,
      enabled_log,
      log_analytics_destination_type
    ]
  }
}
