resource "azurerm_resource_group" "rg" {
  for_each = { for idx, group in var.resource_groups : idx => group }
  name     = each.value.name 
  location = var.location     
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.rg["0"].location
  resource_group_name = azurerm_resource_group.rg["0"].name
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = azurerm_resource_group.rg["0"].name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnets[count.index].address_prefixes
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each            = { for zone in var.private_dns_zones : zone.name => zone }
  name                = each.value.name
  resource_group_name = azurerm_resource_group.rg["1"].name
}