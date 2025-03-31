data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
  tags                     = var.tags

  https_traffic_only_enabled = var.https_traffic_only_enabled

  identity {
    type = var.identity_type
  }

  // Uncomment and set values if you want to enable soft delete
  // blob_properties {
  //   delete_retention_policy {
  //     days = var.delete_retention_days
  //   }
  //   container_delete_retention_policy {
  //     days = var.container_delete_retention_days
  //   }
  // }
}

resource "azurerm_advanced_threat_protection" "example" {
  target_resource_id = azurerm_storage_account.sa.id
  enabled            = var.advanced_threat_protection_enabled
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}