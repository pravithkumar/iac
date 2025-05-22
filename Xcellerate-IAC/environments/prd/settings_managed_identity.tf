locals {
  configure_uai_resources = {

    settings = {
      
      "mi-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                = "mi-${var.app_name}-${var.environment}-${var.location}-001"
        resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        location            = var.location
        tags                = var.tags
      }
    }
  }
}