data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  public_network_access_enabled = false
  tags                     = var.tags

  https_traffic_only_enabled = true

  identity {
    type = "SystemAssigned"
  }

//   blob_properties {
//     delete_retention_policy {
//       days = 1
//     }
//     container_delete_retention_policy {
//       days = 1
//     }
//   }

}

resource "azurerm_advanced_threat_protection" "example" {
  target_resource_id = azurerm_storage_account.sa.id
  enabled            = true
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}

