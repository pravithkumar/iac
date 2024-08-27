provider "azurerm" {
  features {}
}

module "sql_alwayson_cluster" {
  source = "./modules/sql_alwayson_cluster"

  resource_group_name           = var.resource_group_name
  vnet_name                     = var.vnet_name
  vnet_rg_name                  = var.vnet_rg_name
  subnet_name_db                = var.subnet_name_db
  subnet_name_mgmt              = var.subnet_name_mgmt
  subnet_name_pure              = var.subnet_name_pure
  bootdiag_storage_account_name = var.bootdiag_storage_account_name
  bootdiag_storage_account_rg_name = var.bootdiag_storage_account_rg_name
  secret_key_vault_name         = var.secret_key_vault_name
  secret_key_vault_rg_name      = var.secret_key_vault_rg_name
  sqlaoa_2node_primary_vm       = var.sqlaoa-2node-primary-vm-DC10ANS01TFCW
  sqlaoa_2node_secondary_vm     = var.sqlaoa-2node-secondary-vm-DC10ANS01TFCW
}

output "primary_vm_name" {
  value = module.sql_alwayson_cluster.primary_vm_name
}

output "secondary_vm_name" {
  value = module.sql_alwayson_cluster.secondary_vm_name
}
