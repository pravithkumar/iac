output "batch_account_id" {
  value = module.azurebatch.batch_account_id
}
output "batch_pool_id" {
  value = module.azurebatch.batch_pool_id
}
output "storage_account_id" {
  value = module.storage.storage_account_id
}
output "key_vault_uri" {
  value = module.keyvault.key_vault_uri
}
output "subnet_id" {
  value = module.network.subnet_id
}