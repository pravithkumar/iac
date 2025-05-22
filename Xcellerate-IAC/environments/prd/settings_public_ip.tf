locals {
  configure_public_ip_resources = {

    settings = {

      "pip-agw-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
        resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        location            = var.location
        tags                = var.tags
        allocation_method   = "Static"
        domain_name_label   = "nextgen-xcellerate-${var.environment}-${var.location}-agw"
        sku                 = "Standard"
      }
    }
  }
}
