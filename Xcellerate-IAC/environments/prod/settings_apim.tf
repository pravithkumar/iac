locals {
  configure_apim_resources = {
    
    settings = {

      "apim-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                 = "apim-${var.app_name}-${var.environment}-${var.location}-001"
        location             = var.location
        resource_group_name  = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        publisher_name        = "Fortrea"
        publisher_email       = "ashish.bahuguna@fortrea.com"
        sku_name             = "Developer_1"
        virtual_network_type = "Internal"
        virtual_network_configuration = {
          subnet_id = data.azurerm_subnet.snet_xl_prod_apim_001.id
        }
        identity = {
          type         = "UserAssigned"
          identity_ids = [data.azurerm_user_assigned_identity.mi_xl_prod_location_001.id]
        }
        tags = var.tags
      }
    }
  }
}
