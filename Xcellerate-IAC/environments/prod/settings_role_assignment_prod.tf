locals {
  configure_role_assignment_prod = {

    settings = {
      keyvault_prod_role_secret_user = {
        scope                = module.key_vault_prod.kv-xl-prod-eastus-001.id
        role_definition_name = "Key Vault Secrets User"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
      keyvault_prod_role_certificate_officer = {
        scope                = module.key_vault_prod.kv-xl-prod-eastus-001.id
        role_definition_name = "Key Vault Certificate User"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
      key_vault_role_key_vault_administrator = {
        scope                = module.key_vault_prod.kv-xl-prod-eastus-001.id
        role_definition_name = "Key Vault Crypto User"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
    }
  }
}
