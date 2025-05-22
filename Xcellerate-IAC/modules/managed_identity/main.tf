resource "azurerm_user_assigned_identity" "this" {
  name                = var.settings.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  tags                = var.settings.tags
}


