data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}
data "azurerm_user_assigned_identity" "batch_identity" {
  name                = var.batch_identity_name
  resource_group_name = var.resource_group_name
}

