resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes

  dynamic "delegation" {
    for_each = lookup(each.value, "delegation", [])
    content {
      name = delegation.value.name
      service_delegation {
        name    = delegation.value.service_name
        actions = delegation.value.actions
      }
    }
  }

  dynamic "route_table" {
    for_each = each.value.route_table_id != null ? [1] : []
    content {
      id = each.value.route_table_id
    }
  }

  dynamic "network_security_group" {
    for_each = each.value.nsg_id != null ? [1] : []
    content {
      id = each.value.nsg_id
    }
  }
}
