output "batch_account_id" {
  value = module.azurebatch.batch_account_id
}

output "batch_pool_id" {
  value = module.azurebatch.batch_pool_id
}

output "storage_account_id" {
  value = module.storage.storage_account_id
}

output "key_vault_url" {
  value = module.keyvault.vault_url
}

output "subnet_id" {
  value = module.network.subnet_id
}
