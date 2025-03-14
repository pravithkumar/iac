resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku

  dynamic "capacity" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      capacity = var.servicebus_capacity
    }
  }

  dynamic "premium_messaging_partitions" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      premium_messaging_partitions = var.premium_messaging_partitions
    }
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

resource "azurerm_private_endpoint" "servicebus_pe" {
  count = var.sku == "Premium" && length(var.private_endpoints) > 0 ? 1 : 0 # only create for premium and when there are private endpoints

  for_each            = { for pe in var.private_endpoints : pe.name => pe }
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = each.value.subnet_id

  private_service_connection {
    name                           = "servicebus-private-connection-${each.key}"
    private_connection_resource_id = azurerm_servicebus_namespace.servicebus.id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group-${each.key}"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

  depends_on = [azurerm_servicebus_namespace.servicebus]
}