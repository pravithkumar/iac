resource "azurerm_container_registry" "this" {
  name                          = var.settings.name
  resource_group_name           = var.settings.resource_group_name
  location                      = var.settings.location
  sku                           = var.settings.sku
  admin_enabled                 = var.settings.admin_enabled
  zone_redundancy_enabled       = var.settings.sku == "Premium" ? var.settings.zone_redundancy_enabled : null
  public_network_access_enabled = var.settings.public_network_access_enabled
  network_rule_bypass_option    = var.settings.network_rule_bypass_option ? "AzureServices" : "None"
  data_endpoint_enabled         = var.settings.data_endpoint_enabled
  quarantine_policy_enabled     = var.settings.quarantine_policy_enabled
  tags                          = var.settings.tags

  dynamic "identity" {
    for_each = var.settings.identity != null ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "encryption" {
    #for_each = var.settings.encryption != null ? [var.settings.encryption] : []
    for_each = var.settings.encryption != null ? [] : []
    content {
      key_vault_key_id   = encryption.value.key_vault_key_id
      identity_client_id = encryption.value.identity_client_id
    }
  }


  dynamic "georeplications" {
    for_each = var.settings.georeplications != null && var.settings.sku == "Premium" ? var.settings.georeplications : []

    content {
      location                  = georeplications.value.location
      zone_redundancy_enabled   = georeplications.value.zone_redundancy_enabled
      regional_endpoint_enabled = try(georeplications.value.regional_endpoint_enabled, null)
    }
  }

  dynamic "network_rule_set" {

    for_each = var.settings.network_rule_set != null ? [var.settings.network_rule_set] : []

    content {
      default_action = lookup(network_rule_set.value, "default_action", "Allow")

      dynamic "ip_rule" {
        for_each = var.settings.network_rule_set.ip_range
        content {
          action   = "Allow"
          ip_range = ip_rule.value
        }
      }
    }
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "this" {
  count                         = var.settings.private_endpoint != null ? 1 : 0
  name                          = "pe-${var.settings.name}"
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  subnet_id                     = var.settings.private_endpoint.subnet_id
  custom_network_interface_name = replace("pe-${var.settings.name}", "pe-", "nic-pe-")
  tags                          = var.settings.tags
  private_service_connection {
    name                           = "pe-${var.settings.name}"
    private_connection_resource_id = azurerm_container_registry.this.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
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
      private_connection_resource_id    = private_service_connection.value.private_connection_resource_id != null ? private_service_connection.value.private_connection_resource_id : azurerm_container_registry.this.id
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
  custom_network_interface_name = replace(each.key, "pe-", "nic-pe-")
  tags                          = var.settings.tags
  private_service_connection {
    name                           = each.value.connection_name
    private_connection_resource_id = azurerm_container_registry.this.id
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
