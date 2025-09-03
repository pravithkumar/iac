resource "azurerm_role_assignment" "keyvault_access" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.principal_id
}

resource "azurerm_role_assignment" "storage_access" {
  scope                = var.storage_account_id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.principal_id
}

resource "azurerm_role_assignment" "rg_access" {
  scope                = var.resource_group_id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}

data "azurerm_subscription" "current" {}

resource "azurerm_role_assignment" "subscription_access" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = var.principal_id
}
