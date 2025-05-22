resource "azurerm_storage_account" "this" {
  name                              = var.settings.name
  resource_group_name               = var.settings.resource_group_name
  location                          = var.settings.location
  account_kind                      = var.settings.account_kind
  account_tier                      = var.settings.account_tier
  account_replication_type          = var.settings.account_replication_type
  allow_nested_items_to_be_public   = false
  edge_zone                         = var.settings.edge_zone
  https_traffic_only_enabled        = var.settings.https_traffic_only_enabled
  access_tier                       = var.settings.access_tier
  min_tls_version                   = "TLS1_2"
  shared_access_key_enabled         = var.settings.shared_access_key_enabled
  tags                              = var.settings.tags
  large_file_share_enabled          = var.settings.large_file_share_enabled
  nfsv3_enabled                     = var.settings.nfsv3_enabled
  public_network_access_enabled     = var.settings.public_network_access_enabled
  infrastructure_encryption_enabled = var.settings.infrastructure_encryption_enabled
  queue_encryption_key_type         = var.settings.queue_encryption_key_type
  table_encryption_key_type         = var.settings.table_encryption_key_type
  cross_tenant_replication_enabled  = var.settings.cross_tenant_replication_enabled
  is_hns_enabled                    = var.settings.is_hns_enabled
  sftp_enabled                      = var.settings.sftp_enabled
  default_to_oauth_authentication   = var.settings.default_to_oauth_authentication


  dynamic "blob_properties" {
    for_each = var.settings.blob_properties != null ? [var.settings.blob_properties] : []

    content {
      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy != null ? [blob_properties.value.delete_retention_policy] : []
        content {
          days                     = delete_retention_policy.value.days
          permanent_delete_enabled = delete_retention_policy.value.permanent_delete_enabled
        }
      }

      dynamic "restore_policy" {
        for_each = blob_properties.value.restore_policy != null ? [blob_properties.value.restore_policy] : []
        content {
          days = restore_policy.value.days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = blob_properties.value.container_delete_retention_policy != null ? [blob_properties.value.container_delete_retention_policy] : []
        content {
          days = container_delete_retention_policy.value.days
        }
      }
      versioning_enabled       = blob_properties.value.versioning_enabled
      last_access_time_enabled = blob_properties.value.last_access_time_enabled
      change_feed_enabled      = blob_properties.value.change_feed_enabled
    }
  }

  dynamic "static_website" {
    for_each = var.settings.static_website != null ? [var.settings.static_website] : []

    content {
      index_document     = static_website.value.index_document
      error_404_document = try(static_website.value.error_404_document, null)
    }
  }

  dynamic "identity" {
    for_each = var.settings.identity != null ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.settings.customer_managed_key != null ? [var.settings.customer_managed_key] : []
    content {
      key_vault_key_id          = customer_managed_key.value.key_vault_key_id
      managed_hsm_key_id        = customer_managed_key.value.managed_hsm_key_id
      user_assigned_identity_id = customer_managed_key.value.user_assigned_identity_id
    }
  }

  dynamic "routing" {
    for_each = var.settings.routing != null ? [var.settings.routing] : []
    content {
      publish_internet_endpoints  = routing.value.publish_internet_endpoints
      publish_microsoft_endpoints = routing.value.publish_microsoft_endpoints
      choice                      = routing.value.choice
    }
  }


  dynamic "network_rules" {
    for_each = var.settings.network_rules != null ? [var.settings.network_rules] : []
    content {
      default_action             = network_rules.value.default_action
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = network_rules.value.virtual_network_subnet_ids
      bypass                     = network_rules.value.bypass

      dynamic "private_link_access" {
        for_each = network_rules.value.private_link_access != null ? network_rules.value.private_link_access : []
        content {
          endpoint_resource_id = private_link_access.value.endpoint_resource_id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      network_rules[0].private_link_access,
      # network_rules
      tags
    ]
  }
}


resource "azurerm_storage_container" "this" {
  for_each              = try({ for c in var.settings.containers : c.name => c }, {})
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
  #depends_on            = [azurerm_private_endpoint.pvtep_storage]
}

resource "azurerm_storage_blob_inventory_policy" "this" {
  for_each           = try({ for c in var.settings.blob_inventory_policy : c.name => c }, {})
  storage_account_id = azurerm_storage_account.this.id

  dynamic "rules" {

    for_each = each.value.rules != null ? each.value.rules : []
    content {
      name                   = rules.value.name
      storage_container_name = azurerm_storage_container.this[rules.value.storage_container_name].name
      format                 = rules.value.format
      schedule               = rules.value.schedule
      scope                  = rules.value.scope
      schema_fields          = rules.value.schema_fields

      dynamic "filter" {
        for_each = rules.value.filter != null ? [rules.value.filter] : []
        content {
          blob_types            = filter.value.blob_types
          include_blob_versions = filter.value.include_blob_versions
          include_deleted       = filter.value.include_deleted
          include_snapshots     = filter.value.include_snapshots
          prefix_match          = filter.value.prefix_match
          exclude_prefixes      = filter.value.exclude_prefixes
        }
      }
    }
  }
}

resource "azurerm_storage_share" "this" {
  for_each             = try({ for s in var.settings.file_shares : s.name => s }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
  quota                = each.value.quota_in_gb
  enabled_protocol     = each.value.enabled_protocol
  metadata             = each.value.metadata

  dynamic "acl" {
    for_each = each.value.acl != null ? each.value.acl : []

    content {
      id = acl.value.id

      access_policy {
        permissions = acl.value.permissions
        start       = acl.value.start
        expiry      = acl.value.expiry
      }
    }
  }
}

resource "azurerm_storage_queue" "this" {
  for_each             = try({ for q in var.settings.queues : q.name => q }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
}

resource "azurerm_storage_table" "this" {
  for_each             = try({ for t in var.settings.tables : t.name => t }, {})
  name                 = each.key
  storage_account_name = azurerm_storage_account.this.name
}


resource "azurerm_private_endpoint" "this" {
  count                         = var.settings.private_endpoint != null ? 1 : 0
  name                          = "pe-${var.settings.name}"
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  subnet_id                     = var.settings.private_endpoint.subnet_id
  custom_network_interface_name = var.settings.private_endpoint.custom_network_interface_name != null ? var.settings.private_endpoint.custom_network_interface_name : replace("pe-${var.settings.name}", "pe-", "nic-pe-")
  private_service_connection {
    name                           = "pe-${var.settings.name}"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "${var.settings.name}-dns-zone-group"
    private_dns_zone_ids = var.settings.private_endpoint.private_dns_zone_ids
  }
  tags = var.settings.tags
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
      private_connection_resource_id    = private_service_connection.value.private_connection_resource_id != null ? private_service_connection.value.private_connection_resource_id : azurerm_storage_account.this.id
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
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_private_endpoint" "secondary" {
  for_each                      = try({ for n in var.settings.private_endpoint_secondary : n.endpoint_name => n }, {})
  name                          = each.key
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  subnet_id                     = each.value.subnet_id
  custom_network_interface_name = replace(each.key, "pep-", "pepnic-")
  tags                          = var.settings.tags
  private_service_connection {
    name                           = each.value.connection_name
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = each.value.subresource_names
  }

  private_dns_zone_group {
    name                 = "${each.key}-dns-zone-group"
    private_dns_zone_ids = each.value.private_dns_zone_ids
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
