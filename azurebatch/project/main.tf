
module "network" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source              = "../modules/network"
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_name             = var.subnet_name
  subnet_prefix           =var.subnet_prefix
}

module "storage" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source              = "../modules/storage"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_name = var.storage_account_name
}

module "keyvault" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source              = "../modules/keyvault"
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_name      = var.key_vault_name
}

module "access" {
  source = "../modules/access"
  providers = { azurerm = azurerm.integ-nprod-001 }

  principal_id        = "a3480609-66ce-4a3d-a25d-ae350e5b1bda"
  key_vault_id        = module.keyvault.key_vault_id
  storage_account_id  = module.storage.storage_account_id
  resource_group_id   = data.azurerm_resource_group.rg.id
}


module "azurebatch" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
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
  subnet_id                 = module.network.subnet_id
  start_task_command_line   = var.start_task_command_line
  key_vault_id               = var.key_vault_id
  key_vault_url              = var.key_vault_url
  user_assigned_identity_id  = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/optum-delete/providers/Microsoft.ManagedIdentity/userAssignedIdentities/optum-identity"
}
