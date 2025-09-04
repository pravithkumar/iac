resource "azurerm_role_assignment" "umi_kv_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.user_assigned_identity_object_id
}

resource "azurerm_role_assignment" "batch_spn_kv_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = "06d82036-5a43-4d4a-8203-a07095cb42bb"
}
