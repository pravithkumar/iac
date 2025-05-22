resource "azurerm_virtual_network" "vnet" {
  provider            = azurerm.prod
  name                = var.vnet_name
  address_space       = var.address_space
  resource_group_name = var.resource_group_name
  location            = var.location
  #   resource_group_name = var.resource_groups["rg2"].resource_group_name
  #   location            = var.resource_groups["rg2"].location
  tags = var.tags

  lifecycle {
    ignore_changes = [
     tags
    ]
  }
}

resource "azurerm_subnet" "subnet" {
  provider             = azurerm.prod
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
  resource_group_name  = var.resource_group_name
  depends_on           = [azurerm_virtual_network.vnet]
}


