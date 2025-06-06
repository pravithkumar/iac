resource "azurerm_route_table" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  tags                = var.tags

  dynamic "route" {
    for_each = var.routes != null ? var.routes : []
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = lookup(route.value, "next_hop_in_ip_address", null)
    }
  }
}
