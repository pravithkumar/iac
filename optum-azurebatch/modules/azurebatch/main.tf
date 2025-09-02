resource "azurerm_batch_account" "batch" {
  name                         = var.batch_account_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  pool_allocation_mode         = "UserSubscription"
  public_network_access_enabled = false
}

resource "azurerm_batch_pool" "pool" {
  name                = var.pool_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_batch_account.batch.name
  vm_size             = var.vm_size
  deployment_configuration {
    virtual_machine_configuration {
      image_reference {
        publisher = var.image_publisher
        offer     = var.image_offer
        sku       = var.image_sku
        version   = var.image_version
      }
      node_agent_sku_id = var.node_agent_sku_id
    }
  }
  scale_settings {
    fixed_scale {
      target_dedicated_nodes    = var.target_dedicated_nodes
      target_low_priority_nodes = var.target_low_priority_nodes
    }
  }
  network_configuration {
    subnet_id = var.subnet_id
  }
  start_task {
    command_line     = var.start_task_command_line
    wait_for_success = true
    user_identity {
      auto_user {
        elevation_level = "admin"
        scope           = "pool"
      }
    }
  }
}