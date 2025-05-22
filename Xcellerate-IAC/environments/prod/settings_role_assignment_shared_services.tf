locals {
  configure_role_assignment_shared_services = {

    settings = {
      PrivateDNSZone_to_AKS_shared_services_role_secret_user = {
        scope                = data.azurerm_private_dns_zone.privatelink_eastus_azmk8s_io.id
        role_definition_name = "Private DNS Zone Contributor"
        principal_id         = data.azurerm_user_assigned_identity.mi_xl_prod_location_001.principal_id
      }
    }
  }
}
