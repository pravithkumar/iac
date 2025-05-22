resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
  account_kind                      = var.account_kind
  access_tier                       = var.access_tier
  large_file_share_enabled          = var.large_file_share_enabled
  default_to_oauth_authentication   = var.default_to_oauth_authentication
  shared_access_key_enabled         = true
  allow_nested_items_to_be_public   = false
  tags                     = var.tags

  https_traffic_only_enabled = var.https_traffic_only_enabled

  dynamic "identity" {
    for_each = var.identity_type != null ? [1] : []
    content {
      type       = var.identity_type
      identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
    }
  }

  blob_properties {
  delete_retention_policy {
    days                    = var.delete_retention_days
    permanent_delete_enabled = var.permanent_delete_enabled
  }
  container_delete_retention_policy {
    days = var.delete_retention_days
  }
}
}
