terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.7.0"
    }
  }
}


resource "azurerm_virtual_network" "vnet" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }
  providers            =  {azurerm = azurerm.integ-nprod-001}
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
  dynamic "delegation" {
  for_each = each.value.delegations != null ? each.value.delegations : []
  content {
    name = delegation.value.name
    service_delegation {
      name    = delegation.value.service_name
      actions = delegation.value.actions
    }
  }
 }
}

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
    if subnet.nsg_id != null
  }
  providers            =  {azurerm = azurerm.integ-nprod-001}
  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = each.value.nsg_id
}

resource "azurerm_subnet_route_table_association" "rt_assoc" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
    if subnet.route_table_id != null
  }
  providers            =  {azurerm = azurerm.integ-nprod-001}
  subnet_id      = azurerm_subnet.subnets[each.key].id
  route_table_id = each.value.route_table_id
}
