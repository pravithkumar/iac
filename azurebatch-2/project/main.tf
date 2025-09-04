

module "azurebatch" {
  source                    = "../modules/azurebatch"
  location                  = var.location
  resource_group_name       = var.resource_group_name
  batch_account_name        = var.batch_account_name
  pool_name                 = var.pool_name
  vm_size                   = var.vm_size
  image_publisher           = var.image_publisher
  image_offer               = var.image_offer
  image_sku                 = var.image_sku
  image_version             = var.image_version
  node_agent_sku_id         = var.node_agent_sku_id
  target_dedicated_nodes    = var.target_dedicated_nodes
  target_low_priority_nodes = var.target_low_priority_nodes 
  start_task_command_line   = var.start_task_command_line
  key_vault_id              = var.key_vault_id
  key_vault_url             = var.key_vault_url
  user_assigned_identity_id  = var.user_assigned_identity_id
}
