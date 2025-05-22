locals {

  configure_nsg_dmz_resources = {

    settings = {

      "nsg-snet-agw-${var.app_name}-${var.environment}-001" = {
        name                = "nsg-snet-agw-${var.app_name}-${var.environment}-001"
        location            = var.location
        resource_group_name = "rg-network-dmz-inet-${var.location}-001"
        security_rule = {
          AllowHttpInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "*"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "80"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowHttpInbound"
            priority                                   = 1000
            protocol                                   = "Tcp"
            source_address_prefix                      = "*"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowHttpsInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "*"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "443"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowHttpsInbound"
            priority                                   = 1010
            protocol                                   = "Tcp"
            source_address_prefix                      = "*"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowAGPortsInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "*"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "65200-65535"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowAGPortsInbound"
            priority                                   = 1020
            protocol                                   = "Tcp"
            source_address_prefix                      = "*"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
        }
        subnet_id = data.azurerm_subnet.snet_agw_dmz.id
        tags      = var.tags
      }

      "nsg-snet-${var.app_name}-${var.environment}-pe-001" = {
        name                = "nsg-snet-${var.app_name}-${var.environment}-pe-001"
        location            = var.location
        resource_group_name = "rg-network-dmz-inet-${var.location}-001"
        security_rule = {
          Allow-AzureResourceManager = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "*"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "Allow-AzureResourceManager"
            priority                                   = 1010
            protocol                                   = "*"
            source_address_prefix                      = "AzureResourceManager"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
          Allow-AzureFrontDoorFirstParty = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "*"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "Allow-AzureFrontDoor.FirstParty"
            priority                                   = 1020
            protocol                                   = "*"
            source_address_prefix                      = "AzureFrontDoor.FirstParty"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
          Allow-AzureFrontdoorFrontend = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "*"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "Allow-AzureFrontdoor.Frontend"
            priority                                   = 1030
            protocol                                   = "*"
            source_address_prefix                      = "AzureFrontdoor.Frontend"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
        }
        subnet_id = data.azurerm_subnet.snet_pe_dmz.id
        tags      = var.tags
      }
    }
  }
}




