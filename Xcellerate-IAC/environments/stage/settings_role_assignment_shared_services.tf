locals {
  configure_role_assignment_shared_services = {

    settings = {

      PrivateDNSZone_to_AKS_shared_services_role_secret_user = {
        scope                = data.azurerm_private_dns_zone.privatelink_azmk8s_io.id
        role_definition_name = "Private DNS Zone Contributor"
        principal_id         = module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].principal_id
      }
    }
  }
}
