locals {
  configure_role_assignment_dmz = {

    settings = {
      appgw_to_keyvault_dmz_role_secret_user = {
        scope                = module.key_vault_dmz["kv-${var.app_name}-${var.environment}-dmz-${var.location}-001"].id
        role_definition_name = "Key Vault Secrets User"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }

      appgw_to_keyvault_dmz_role_certificate_user = {
        scope                = module.key_vault_dmz["kv-${var.app_name}-${var.environment}-dmz-${var.location}-001"].id
        role_definition_name = "Key Vault Certificate User"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }

      appgw_to_keyvault_dmz_role_crypto_user = {
        scope                = module.key_vault_dmz["kv-${var.app_name}-${var.environment}-dmz-${var.location}-001"].id
        role_definition_name = "Key Vault Crypto User"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }
    }
  }
}
