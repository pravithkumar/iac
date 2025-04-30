resource "random_password" "spn_password" {
  length  = 16
  special = true
}

data "azuread_service_principal" "by_name" {
  display_name = "pravith_sso_test"
}

resource "azuread_service_principal_password" "example" {  
  service_principal_id = "/servicePrincipals/a496c409-1b17-47b5-94bc-3a42ba9fb87c"
  end_date             = timeadd(timestamp(), "2160h") # Valid for 90 days
}

//service_principal_id = "/servicePrincipals/39fe4fa5-a205-4949-8895-5e99d8bab126"  
data "azurerm_key_vault" "existing" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_secret" "example" {
  name         = "spn-password"
  value        = azuread_service_principal_password.example.value
  key_vault_id = data.azurerm_key_vault.existing.id
}

