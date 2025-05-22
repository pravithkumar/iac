locals {
  configure_udr_dmz = {

    settings = {

      "rt-${var.app_name}-agw-${var.environment}-${var.location}" = {
        name                = "rt-${var.app_name}-agw-${var.environment}-${var.location}"
        location            = var.location
        resource_group_name = "rg-network-dmz-inet-${var.location}-001"

        route = [
          {
            name                   = "route-to-palo"
            address_prefix         = "10.48.94.96/28"
            next_hop_type          = "VirtualAppliance"
            next_hop_in_ip_address = "10.48.113.10"
          }
        ]
        subnets = concat(
          [
            for subnet_name in [
              "snet-agw-${var.app_name}-${var.environment}-001"
              ] : {
              subnet_id = data.azurerm_subnet.snet_agw_dmz.id
            }
        ], )
        tags = var.tags
      }
    }
  }
}