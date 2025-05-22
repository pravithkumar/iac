locals {
  configure_role_assignment_applz = {

    settings = {
      keyvault_applz_role_certificates_officer = {
        scope = data.azurerm_key_vault.kv_applz.id
        role_definition_name = "Key Vault Administrator"
        principal_id         = data.azurerm_user_assigned_identity.user_mi.principal_id
    }
    }
  }
}
