locals {
  default_nsg_rules = {}

  configure_nsg_prod_resources = {

    settings = {

      "nsg-snet-${var.app_name}-${var.environment}-pe-001" = {
        name                = "nsg-snet-${var.app_name}-${var.environment}-pe-001"
        location            = var.location
        resource_group_name = "rg-network-${var.app_name}-${var.location}-002"
        security_rule = {
          Allow-AzureActiveDirectory = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "*"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "Allow-AzureActiveDirectory"
            priority                                   = 1000
            protocol                                   = "*"
            source_address_prefix                      = "AzureActiveDirectory"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
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
        subnet_id = data.azurerm_subnet.snet_pe.id
        tags      = var.tags
      }

      "nsg-snet-${var.app_name}-${var.environment}-aks-001" = {
        name                = "nsg-snet-${var.app_name}-${var.environment}-aks-001"
        location            = var.location
        resource_group_name = "rg-network-${var.app_name}-${var.location}-002"
        security_rule       = {}
        subnet_id           = data.azurerm_subnet.snet_aks.id
        tags                = var.tags
      }

      "nsg-snet-${var.app_name}-${var.environment}-apim-001" = {
        name                = "nsg-snet-${var.app_name}-${var.environment}-apim-001"
        location            = var.location
        resource_group_name = "rg-network-${var.app_name}-${var.location}-002"
        security_rule = {
          AllowHttpInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "80"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowHttpInbound"
            priority                                   = 1000
            protocol                                   = "Tcp"
            source_address_prefix                      = "Internet"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
          AllowHttpsInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "443"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowHttpsInbound"
            priority                                   = 1010
            protocol                                   = "Tcp"
            source_address_prefix                      = "Internet"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
          AllowAPIInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "3443"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowAPIInbound"
            priority                                   = 1020
            protocol                                   = "Tcp"
            source_address_prefix                      = "ApiManagement"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowLoadBalancerInbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "VirtualNetwork"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "6390"
            destination_port_ranges                    = []
            direction                                  = "Inbound"
            name                                       = "AllowLoadBalancerInbound"
            priority                                   = 1030
            protocol                                   = "Tcp"
            source_address_prefix                      = "AzureLoadBalancer"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowHttpsOutbound1 = {
            access                                     = "Allow"
            destination_address_prefix                 = "Storage"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "443"
            destination_port_ranges                    = []
            direction                                  = "Outbound"
            name                                       = "AllowHttpsOutbound1"
            priority                                   = 1000
            protocol                                   = "Tcp"
            source_address_prefix                      = "VirtualNetwork"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowAzureADOutbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "AzureActiveDirectory"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "443"
            destination_port_ranges                    = []
            direction                                  = "Outbound"
            name                                       = "AllowAzureADOutbound"
            priority                                   = 1010
            protocol                                   = "Tcp"
            source_address_prefix                      = "VirtualNetwork"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowKeyVaultOutbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "AzureKeyVault"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "443"
            destination_port_ranges                    = []
            direction                                  = "Outbound"
            name                                       = "AllowKeyVaultOutbound"
            priority                                   = 1020
            protocol                                   = "Tcp"
            source_address_prefix                      = "VirtualNetwork"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowHttpsOutbound = {
            access                                     = "Allow"
            destination_address_prefix                 = "AzureMonitor"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "1886"
            destination_port_ranges                    = []
            direction                                  = "Outbound"
            name                                       = "AllowHttpsOutbound"
            priority                                   = 1030
            protocol                                   = "Tcp"
            source_address_prefix                      = "VirtualNetwork"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }

          AllowHttpsOutbound2 = {
            access                                     = "Allow"
            destination_address_prefix                 = "AzureMonitor"
            destination_address_prefixes               = []
            destination_application_security_group_ids = []
            destination_port_range                     = "443"
            destination_port_ranges                    = []
            direction                                  = "Outbound"
            name                                       = "AllowHttpsOutbound2"
            priority                                   = 1040
            protocol                                   = "Tcp"
            source_address_prefix                      = "VirtualNetwork"
            source_address_prefixes                    = []
            source_application_security_group_ids      = []
            source_port_range                          = "*"
            source_port_ranges                         = []
          }
        }
        subnet_id = data.azurerm_subnet.snet_apim.id
        tags      = var.tags
      }
    }
  }
}


