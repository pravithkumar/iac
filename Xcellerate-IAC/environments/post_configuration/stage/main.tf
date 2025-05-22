
# resource "time_sleep" "wait" {
#   count           = 2
#   create_duration = "10s"
# }


#module to deploy the role assignment
# module "role_assignment_applz" {
#   for_each = local.configure_role_assignment_applz.settings
#   source   = "../../../modules/role_assignment"
#   providers = {
#     azurerm = azurerm.applz
#   }
#   settings   = each.value
# }

#module to deploy the role assignment
module "role_assignment_dmz" {
  for_each = local.configure_role_assignment_dmz.settings
  source   = "../../../modules/role_assignment"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#  #module to upload certificate to the Key Vault AppLZ
#  module "key_vault_applz_certificate" {
#    for_each = local.configure_kv_applz_certificate.settings
#    source   = "../../../modules/keyvault_certificate"
#    providers = {
#      azurerm = azurerm.applz
#    }
#    settings   = each.value
#    depends_on = [module.role_assignment_applz]
#   }

#module to upload certificate to the Key Vault DMZ
# module "key_vault_dmz_certificate" {
#   for_each = local.configure_kv_dmz_certificate.settings
#   source   = "../../../modules/keyvault_certificate"
#   providers = {
#     azurerm = azurerm.dmz
#   }
#   settings   = each.value
#   depends_on = [module.role_assignment_dmz]
# }

// resource "azurerm_key_vault_certificate" "kv_certificate_dmz_agw" {
//   name         = "cert-int-xl-stg-eastus-agw"
//   key_vault_id = data.azurerm_key_vault.kv_dmz.id

//   certificate {
//      contents = filebase64(var.CERT_APPGW)
//      password = var.CERT_PASSWORD
//   }
//   depends_on = [module.role_assignment_dmz]
// }

// #module to deploy the Application Gateway
// module "application_gateway" {
//   for_each = local.configure_appgw_resources.settings
//   source   = "../../../modules/application_gateway"
//   providers = {
//     azurerm.dmz = azurerm.dmz
//   }
//   settings   = each.value
//   depends_on = [azurerm_key_vault_certificate.kv_certificate_dmz_agw]
// }


// # #module to deploy the API Management
// module "apim" {
//   for_each = local.configure_apim_resources.settings
//   source   = "../../../modules/apim"
//   providers = {
//     azurerm = azurerm.applz
//   }
//   settings   = each.value
//   depends_on = [azurerm_key_vault_certificate.kv_certificate_applz_apim]
// }
