resource "azuread_application_password" "this" {  
  application_id = "/applications/d75ad180-a90a-4fee-91af-48c3849f6272"
  display_name   = var.app_password_display_name
  end_date       = timeadd(timestamp(), "2160h") # Valid for 90 days
}

data "azurerm_key_vault" "existing" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_secret" "this" {
  name         = var.app_kv_secret_name
  value        = azuread_application_password.this.value
  key_vault_id = data.azurerm_key_vault.existing.id
}