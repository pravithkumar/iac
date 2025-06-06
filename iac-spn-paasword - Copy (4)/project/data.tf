data "azurerm_key_vault" "existing" {
  name                = var.keyvault_name
  resource_group_name = var.resource_group_name
}