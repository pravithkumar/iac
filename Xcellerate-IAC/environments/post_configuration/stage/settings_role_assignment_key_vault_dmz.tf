locals {
  configure_role_assignment_dmz = {

    settings = {
      keyvault_dmz_role_keyvault_administrator = {
        scope                = data.azurerm_key_vault.kv_dmz.id
        role_definition_name = "Key Vault Administrator"
        principal_id         = data.azurerm_user_assigned_identity.user_mi.principal_id
      }
    }
  }
}
