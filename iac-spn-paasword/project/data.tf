data "azurerm_key_vault" "existing" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}

// data "azuread_service_principal" "example" {
//   object_id = var.service_principal_id
// }
