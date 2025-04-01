resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  public_network_access_enabled = var.public_network_access_enabled
  capacity                     = var.sku == "Premium" ? var.servicebus_capacity : null
  premium_messaging_partitions = var.sku == "Premium" ? var.premium_messaging_partitions : null

   dynamic "identity" {
    for_each = var.enable_managed_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  network_rule_set {
    // public_network_access_enabled = var.public_network_access_enabled
    trusted_services_allowed      = var.trusted_services_allowed
}

}

resource "azurerm_servicebus_queue" "queues" {
  for_each              = toset(var.queue_names)
  name                  = each.value
  namespace_id          = azurerm_servicebus_namespace.servicebus.id
  max_size_in_megabytes = var.queue_max_size
  # Other queue settings as needed
}

resource "azurerm_servicebus_topic" "topics" {
  for_each              = toset(var.topic_names)
  name                  = each.value
  namespace_id          = azurerm_servicebus_namespace.servicebus.id
  max_size_in_megabytes = var.topic_max_size
  # Other topic settings as needed
}

resource "azurerm_servicebus_subscription" "subscriptions" {
  for_each            = toset(var.topic_names)
  name                = "${each.value}-subscription"
  topic_id            = azurerm_servicebus_topic.topics[each.value].id
  max_delivery_count  = var.subscription_max_delivery_count
  # Other subscription settings as needed
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_servicebus_namespace.servicebus.id
  role_definition_name = "Azure Service Bus Data Owner"
  principal_id         = azurerm_servicebus_namespace.servicebus.identity[0].principal_id
}
