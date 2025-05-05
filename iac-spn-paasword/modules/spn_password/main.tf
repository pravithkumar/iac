data "azuread_application" "example" {
  display_name = "pravith_sso_test"
}

resource "azuread_application_password" "this" {  
  application_id = data.azuread_application.example.object_id
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