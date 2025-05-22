resource "azurerm_user_assigned_identity" "mid" {
  provider            = azurerm.prod
  location            = var.location
  name                = var.identity_name
  resource_group_name = var.resource_group_name
  tags                = var.tags

  lifecycle {
    ignore_changes = [
     tags
    ]
  }
}
