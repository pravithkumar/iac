data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "umi_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.user_assigned_identity_object_id

  key_permissions = [
    "Get",
    "List"    
   ]
}

resource "azurerm_key_vault_access_policy" "batch_spn_policy" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "06d82036-5a43-4d4a-8203-a07095cb42bb"

  key_permissions = [
    "Get",
    "List"    
  ]
}

