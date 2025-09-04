resource "azurerm_role_assignment" "umi_kv_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.user_assigned_identity_object_id
}

resource "azurerm_role_assignment" "batch_spn_kv_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "e4c6a7f3-4020-45c5-a7c2-1f7b3f5c1a10"
}
