locals {
  configure_role_assignment_prod = {

    settings = {
      keyvault_prod_role_secret_user = {
        scope = module.key_vault_prod["kv-${var.app_name}-${var.environment}-${var.location}-001"].id
        role_definition_name = "Key Vault Secrets User"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }

      keyvault_prod_role_certificate_officer = {
        scope = module.key_vault_prod["kv-${var.app_name}-${var.environment}-${var.location}-001"].id
        role_definition_name = "Key Vault Certificate User"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id 
      }

      key_vault_role_key_vault_administrator = {
        scope = module.key_vault_prod["kv-${var.app_name}-${var.environment}-${var.location}-001"].id
        role_definition_name = "Key Vault Crypto User"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }

      vNet_role_network_Contributor = {
        scope                = data.azurerm_virtual_network.vnet_applz.id
        role_definition_name = "Network Contributor"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }
    }
  }
}
