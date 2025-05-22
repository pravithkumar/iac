locals {
  configure_udr_prod = {

    settings = {
    
      "rt-${var.app_name}-aks-${var.environment}-${var.location}" = {
        name                = "rt-${var.app_name}-aks-${var.environment}-${var.location}"
        location            = var.location
        resource_group_name = "rg-network-${var.app_name}-${var.location}-001"
        #disable_bgp_route_propagation = true

        route = [
          {
            name                   = "route-to-palo"
            address_prefix         = "0.0.0.0/0"
            next_hop_type          = "VirtualAppliance"
            next_hop_in_ip_address = "10.48.113.10"
          }
        ]
        subnets = concat(
          [
            for subnet_name in [
              "snet-${var.app_name}-${var.environment}-aks-001"
              ] : {
              subnet_id = data.azurerm_subnet.snet_xl_prod_aks_001.id
            }
        ], )
        tags = var.tags
      }
    }
  }
}