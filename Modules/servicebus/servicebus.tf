resource "azurerm_servicebus_namespace" "servicebus" {
  name                = var.servicebus_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = 1
  premium_messaging_partitions = 1
}

resource "azurerm_servicebus_queue" "example_queue" {
  name                = "example-queue"
  namespace_id        = azurerm_servicebus_namespace.servicebus.id
  max_size_in_megabytes = 1024 # Adjust as needed
  # Other queue settings as needed
}

resource "azurerm_servicebus_topic" "example_topic" {
  name                = "example-topic"
  namespace_id        = azurerm_servicebus_namespace.servicebus.id
  max_size_in_megabytes = 1024 # Adjust as needed
  # Other topic settings as needed
}

resource "azurerm_servicebus_subscription" "example_subscription" {
  name                = "example-subscription"
  topic_id            = azurerm_servicebus_topic.example_topic.id
  max_delivery_count  = 10 # Adjust as needed
  # Other subscription settings as needed
}

resource "azurerm_private_endpoint" "servicebus_pe" {
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