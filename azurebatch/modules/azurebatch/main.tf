
resource "azurerm_batch_account" "batch" {
  name                          = var.batch_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  pool_allocation_mode          = "UserSubscription"
  public_network_access_enabled = false

  identity {
    type         = "UserAssigned"
    identity_ids = ["/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/optum-delete/providers/Microsoft.ManagedIdentity/userAssignedIdentities/optum-identity"]
  }

  key_vault_reference {
    id  = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/optum-delete/providers/Microsoft.KeyVault/vaults/optum-kv-del-2"
    url = "https://optum-kv-del-2.vault.azure.net/"
  }
}

resource "azurerm_batch_pool" "pool" {
  name                = "testpool"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_batch_account.batch.name
  vm_size             = "Standard_D2_v3"
  node_agent_sku_id   = "batch.node.ubuntu 20.04"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20_04-lts"
    version   = "latest"
  }

  fixed_scale {
    target_dedicated_nodes    = 1
    target_low_priority_nodes = 0
  }

  start_task {
    command_line     = "/bin/bash -c 'echo Hello'"
    wait_for_success = true

    user_identity {
      auto_user {
        elevation_level = "Admin"
        scope           = "Pool"
      }
    }
  }
}

