resource "azurerm_resource_group" "rg1" {
  name     = var.resource_group_1_name
  location = var.location
}

resource "azurerm_resource_group" "rg2" {
  name     = var.resource_group_2_name
  location = var.location
}

resource "azurerm_resource_group" "rg3" {
  name     = var.resource_group_3_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_subnet" "subnet" {
 count               = length(var.subnet_names)
  name                = var.subnet_names[count.index]
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = [var.subnet_prefixes[count.index]]
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each            = var.private_dns_zones
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg2.name
}
