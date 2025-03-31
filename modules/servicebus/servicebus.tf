resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  public_network_access_enabled = false
  capacity                     = var.sku == "Premium" ? var.servicebus_capacity : null
  premium_messaging_partitions = var.sku == "Premium" ? var.premium_messaging_partitions : null

  trusted_service_access_enabled = true
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