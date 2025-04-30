resource "random_password" "spn_password" {
  length  = 16
  special = true
}

resource "azuread_service_principal_password" "example" {
  service_principal_id = var.service_principal_id
  value                = random_password.spn_password.result
  end_date             = timeadd(timestamp(), "2160h")  # Valid for 90 days
}

data "azurerm_key_vault" "existing" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
  location = var.location_test
}

resource "azurerm_key_vault_secret" "example" {
  name         = "spn-password"
  value        = random_password.spn_password.result
  key_vault_id = data.azurerm_key_vault.existing.id
}
