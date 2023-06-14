# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = var.name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}