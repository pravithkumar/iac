locals {
  configure_apim_resources = {

    settings = {

      "apim-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                 = data.azurerm_api_management.apim.name
        location             = data.azurerm_api_management.apim.location
        resource_group_name  = data.azurerm_api_management.apim.resource_group_name
        publisher_name       = "Fortrea"
        publisher_email      = "sandeepnarayan.shukla@fortrea.com"
        notification_sender_email = "apimgmt-noreply@mail.windowsazure.com"
        gateway_url = "https://apim-${var.app_name}-${var.environment}-${var.location}-001.azure-api.net"
        gateway_regional_url = "https://apim-${var.app_name}-${var.environment}-${var.location}-001-${var.location}-01.regional.azure-api.net"
        portal_url = "https://apim-${var.app_name}-${var.environment}-${var.location}-001.portal.azure-api.net"
        developer_portal_url = "https://apim-${var.app_name}-${var.environment}-${var.location}-001.developer.azure-api.net"
        management_api_url = "https://apim-${var.app_name}-${var.environment}-${var.location}-001.management.azure-api.net"
        scm_url = "https://apim-${var.app_name}-${var.environment}-${var.location}-001.scm.azure-api.net"

        hostname_configuration = {
        management = {
        host_name = "apim-${var.app_name}-${var.environment}-${var.location}-001.azure-api.net"
            }
        proxy = { 
        default_ssl_binding = false
        host_name = "apim-${var.app_name}-${var.environment}-${var.location}-001.azure-api.net"
        certificate_source = "BuiltIn"
    }
  }

   hostname_configuration = {
    management = {
        host_name = "nextgen-xcellerate-${var.environment}01-${var.location}-api.cds.fortrea.com"
    }
    proxy = { 
        default_ssl_binding = false
        host_name = "nextgen-xcellerate-${var.environment}01-${var.location}-api.cds.fortrea.com"
        certificate_source = "Custom"
    }
  }

 proxy = {
    default_ssl_binding = true
    host_name = "nextgen-xcellerate-${var.environment}01-${var.location}-api.cds.fortrea.com"
    negotiate_client_certificate = false
    certificate = "" # needs to be updated
    certificate_password = "" # needs to be updated

 } 

   public_ip_addresses = [""] # needs to be updated
  private_ip_addresses = "" # needs to be updated

        sku_name             = "Developer_1"
        virtual_network_type = "Internal"
        public_network_access_enabled = true

        virtual_network_configuration = {
          subnet_id = data.azurerm_api_management.apim.virtual_network_configuration.subnet_id
        }
        identity = {
          type         = "UserAssigned"
          identity_ids = [data.azurerm_user_assigned_identity.user_mi.id]
        }
        tags = data.azurerm_api_management.apim.tags
      }
    }
  }
}
