resource "azurerm_batch_account" "batch" {
  name                          = var.batch_account_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  pool_allocation_mode          = "UserSubscription"
  public_network_access_enabled = true
  allowed_authentication_modes  = ["AAD"]

  identity {
    type         = "UserAssigned"
    identity_ids = [var.user_assigned_identity_id]
  }

  key_vault_reference {
    id  = var.key_vault_id
    url = var.key_vault_url
  }
}

resource "azurerm_batch_pool" "pool" {
  name                = var.pool_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_batch_account.batch.name
  vm_size             = var.vm_size
  node_agent_sku_id   = var.node_agent_sku_id

  storage_image_reference {    
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  fixed_scale {
    target_dedicated_nodes    = 1
    target_low_priority_nodes = 0
  }

  start_task {
    command_line     = "cmd /c echo Hello from Windows"
    wait_for_success = true

    user_identity {
      auto_user {
        elevation_level = "Admin"
        scope           = "Pool"
      }
    }
  }
}
