resource "azurerm_redis_cache" "this" {
  name                = var.settings.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  capacity            = var.settings.capacity
  family              = contains(["Basic", "Standard"], var.settings.sku_name) == true ? "C" : "P"
  sku_name            = var.settings.sku_name
  #enable_non_ssl_port           = var.settings.enable_non_ssl_port
  minimum_tls_version           = var.settings.minimum_tls_version
  public_network_access_enabled = var.settings.public_network_access_enabled
  tags                          = var.settings.tags
  shard_count                   = var.settings.sku_name == "Premium" ? var.settings.shard_count : null
  dynamic "redis_configuration" {
    for_each = var.settings.redis_configuration != null ? [var.settings.redis_configuration] : []

    content {
      #enable_authentication           = var.settings.redis_configuration.enable_authentication
      maxmemory_reserved              = contains(["Premium", "Standard"], var.settings.sku_name) == true ? var.settings.redis_configuration.maxmemory_reserved : null
      maxmemory_delta                 = contains(["Premium", "Standard"], var.settings.sku_name) == true ? var.settings.redis_configuration.maxmemory_delta : null
      maxfragmentationmemory_reserved = contains(["Premium", "Standard"], var.settings.sku_name) == true ? var.settings.redis_configuration.maxfragmentationmemory_reserved : null
      maxmemory_policy                = redis_configuration.value.maxmemory_policy
      rdb_backup_enabled              = var.settings.sku_name == "Premium" ? redis_configuration.value.rdb_backup_enabled : null
      rdb_backup_frequency            = redis_configuration.value.rdb_backup_enabled == true ? redis_configuration.value.rdb_backup_frequency : null
      rdb_backup_max_snapshot_count   = redis_configuration.value.rdb_backup_enabled == true ? redis_configuration.value.rdb_backup_max_snapshot_count : null
    }
  }

  dynamic "identity" {
    for_each = var.settings.identity != null ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_private_endpoint" "this" {
  count                         = var.settings.private_endpoint != null ? 1 : 0
  name                          = "pe-${var.settings.name}"
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  subnet_id                     = var.settings.private_endpoint.subnet_id
  custom_network_interface_name = replace("pe-${var.settings.name}", "pe-", "penic-")
  tags                          = var.settings.tags
  private_service_connection {
    name                           = "pe-${var.settings.name}"
    private_connection_resource_id = azurerm_redis_cache.this.id
    is_manual_connection           = false
    subresource_names              = ["redisCache"]
  }

  dynamic "private_dns_zone_group" {
    for_each = var.settings.private_endpoint.private_dns_zone_ids != null ? ["enabled"] : []
    content {
      name                 = "pe-${var.settings.name}-dns-zone-group"
      private_dns_zone_ids = var.settings.private_endpoint.private_dns_zone_ids
    }
  }
  lifecycle {
    ignore_changes = [
     tags
    ]
  }
}


resource "azurerm_private_endpoint" "additional" {

  for_each = try({ for n in var.settings.private_endpoints : n.name => n }, {})

  name                          = each.key
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  custom_network_interface_name = each.value.custom_network_interface_name
  subnet_id                     = each.value.subnet_id
  tags                          = var.settings.tags

  dynamic "private_service_connection" {

    for_each = each.value.private_service_connection != null ? [each.value.private_service_connection] : []

    content {
      name                              = private_service_connection.value.name
      private_connection_resource_id    = private_service_connection.value.private_connection_resource_id != null ? private_service_connection.value.private_connection_resource_id : azurerm_redis_cache.this.id
      is_manual_connection              = private_service_connection.value.is_manual_connection
      subresource_names                 = private_service_connection.value.subresource_names
      private_connection_resource_alias = private_service_connection.value.private_connection_resource_alias
      request_message                   = private_service_connection.value.request_message

    }
  }

  dynamic "private_dns_zone_group" {

    for_each = each.value.private_dns_zone_group != null ? [each.value.private_dns_zone_group] : []
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = private_dns_zone_group.value.private_dns_zone_ids
    }
  }

  dynamic "ip_configuration" {

    for_each = each.value.ip_configuration != null ? each.value.ip_configuration : []

    content {
      name               = ip_configuration.value.name
      subresource_name   = ip_configuration.value.subresource_name
      private_ip_address = ip_configuration.value.private_ip_address
      member_name        = ip_configuration.value.member_name
    }

  }

  lifecycle {
    ignore_changes = [tags]
  }


}
