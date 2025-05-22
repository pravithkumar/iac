resource "azurerm_monitor_data_collection_rule" "this" {
  name                        = var.settings.name
  resource_group_name         = var.settings.resource_group_name
  location                    = var.settings.location
  data_collection_endpoint_id = var.settings.data_collection_endpoint_id
  kind                        = var.settings.kind
  tags                        = var.settings.tags
  dynamic "destinations" {
    for_each = var.settings.destinations != null ? [var.settings.destinations] : []
    content {
      dynamic "log_analytics" {
        for_each = destinations.value.log_analytics != null ? destinations.value.log_analytics : []
        content {
          name                  = log_analytics.value.name
          workspace_resource_id = log_analytics.value.workspace_resource_id
        }
      }

    }
  }

  dynamic "data_flow" {
    for_each = var.settings.data_flow != null ? var.settings.data_flow : []
    content {
      streams      = data_flow.value.streams
      destinations = data_flow.value.destinations
    }

  }

  dynamic "data_sources" {
    for_each = var.settings.data_sources != null ? [var.settings.data_sources] : []
    content {

      dynamic "extension" {
        for_each = data_sources.value.extension != null ? data_sources.value.extension : []
        content {
          name           = extension.value.name
          streams        = extension.value.streams
          extension_name = extension.value.extension_name
          extension_json = extension.value.extension_json
        }
      }

      dynamic "performance_counter" {
        for_each = data_sources.value.performance_counter != null ? data_sources.value.performance_counter : []
        content {
          counter_specifiers            = performance_counter.value.counter_specifiers
          name                          = performance_counter.value.name
          sampling_frequency_in_seconds = performance_counter.value.sampling_frequency_in_seconds
          streams                       = performance_counter.value.streams
        }
      }
    }
  }
}

resource "azurerm_monitor_data_collection_rule_association" "this" {
  for_each                = try({ for n in var.settings.data_collection_rule_association : n.name => n }, {})
  name                    = each.key
  target_resource_id      = each.value.target_resource_id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.this.id
}
