locals {
  configure_role_assignment_dmz = {

    settings = {
      appgw_to_keyvault_dmz_role_secret_user = {
        scope                = module.key_vault_dmz.kv-xl-dmz-eastus-001.id
        role_definition_name = "Key Vault Secrets User"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
      appgw_to_keyvault_dmz_role_certificate_user = {
        scope                = module.key_vault_dmz.kv-xl-dmz-eastus-001.id
        role_definition_name = "Key Vault Certificate User"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
      appgw_to_keyvault_dmz_role_crypto_user = {
        scope                = module.key_vault_dmz.kv-xl-dmz-eastus-001.id
        role_definition_name = "Key Vault Crypto User"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
    }
  }
}
