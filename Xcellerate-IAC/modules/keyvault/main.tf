locals {
  tenant_id = data.azuread_client_config.current.tenant_id
}
data "azuread_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  #checkov:skip=CKV_AZURE_40:Ensure that the expiration date is set on all keys
  #checkov:skip=CKV2_AZURE_32:Ensure private endpoint is configured to key vault
  name                            = var.settings.azurerm_key_vault_name
  location                        = var.settings.location
  resource_group_name             = var.settings.resource_group_name
  enabled_for_disk_encryption     = var.settings.enabled_for_disk_encryption
  tenant_id                       = var.settings.tenant_id
  soft_delete_retention_days      = var.settings.soft_delete_retention_days
  purge_protection_enabled        = var.settings.purge_protection_enabled
  tags                            = var.settings.tags
  sku_name                        = var.settings.sku_name
  enabled_for_template_deployment = var.settings.enabled_for_template_deployment
  enabled_for_deployment          = var.settings.enabled_for_deployment
  enable_rbac_authorization       = var.settings.enable_rbac_authorization
  public_network_access_enabled   = var.settings.public_network_access_enabled

  dynamic "network_acls" {
    for_each = var.settings.network_acls != null ? var.settings.network_acls : []

    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_private_endpoint" "this" {
  count                         = var.settings.private_endpoint != null ? 1 : 0
  name                          = "pe-${var.settings.azurerm_key_vault_name}"
  location                      = var.settings.location
  resource_group_name           = var.settings.resource_group_name
  subnet_id                     = var.settings.private_endpoint.subnet_id
  custom_network_interface_name = var.settings.private_endpoint.custom_network_interface_name != null ? var.settings.private_endpoint.custom_network_interface_name : replace("pe-${var.settings.azurerm_key_vault_name}", "pe-", "nic-pe-")
  tags                          = var.settings.tags

  private_service_connection {
    name                           = "pe-${var.settings.azurerm_key_vault_name}"
    private_connection_resource_id = azurerm_key_vault.this.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  dynamic "private_dns_zone_group" {
    for_each = var.settings.private_endpoint.private_dns_zone_ids != null ? ["enabled"] : []
    content {
      name                 = "pe-${var.settings.azurerm_key_vault_name}-dns-zone-group"
      private_dns_zone_ids = var.settings.private_endpoint.private_dns_zone_ids
    }
  }
  lifecycle {
    ignore_changes = [private_dns_zone_group, tags]
  }

}


resource "azurerm_key_vault_key" "this" {
  for_each        = try({ for n in var.settings.key_vault_key : n.name => n }, {})
  name            = each.key
  key_vault_id    = azurerm_key_vault.this.id
  key_type        = each.value.key_type
  key_size        = each.value.key_size
  key_opts        = each.value.key_opts
  expiration_date = local.expiration_date

  dynamic "rotation_policy" {
    for_each = each.value.rotation_policy != null ? each.value.rotation_policy : []
    content {
      automatic { time_before_expiry = rotation_policy.value.time_before_expiry }
      expire_after         = rotation_policy.value.expire_after
      notify_before_expiry = rotation_policy.value.notify_before_expiry
    }
  }

  # rotation_policy {
  #   expire_after         = "P24M"
  #   notify_before_expiry = "P30D"
  #   automatic {
  #     time_before_expiry = "P20D"
  #   }
  # }
  lifecycle {
    ignore_changes = [expiration_date, rotation_policy, key_opts, not_before_date, tags]
  }
  depends_on = [azurerm_key_vault.this, azurerm_private_endpoint.this]
}



#addons
resource "tls_private_key" "vmssh" {
  for_each  = try({ for n in var.settings.vm_ssh_generate : n.name => n }, {})
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "azurerm_key_vault_secret" "vmssh" {
  for_each        = try({ for n in var.settings.vm_ssh_generate : n.name => n }, {})
  name            = each.key
  value           = tls_private_key.vmssh[each.key].private_key_pem
  key_vault_id    = azurerm_key_vault.this.id
  expiration_date = "2026-12-31T00:00:00Z"
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
      private_connection_resource_id    = private_service_connection.value.private_connection_resource_id != null ? private_service_connection.value.private_connection_resource_id : azurerm_key_vault.this.id
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




