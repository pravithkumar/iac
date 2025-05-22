#  locals {
#    configure_kv_applz_certificate = {

#     settings = {

#       "api-certificate" = {
#         name          = var.CERT_API
#         key_vault_id  =  data.azurerm_key_vault.kv_applz.id

#       certificate = {
#          contents = var.CERT_APPGW
#          password = var.CERT_PASSWORD
#       }
#       }


#       "aks-certificate" = {
#         name          = var.
#         key_vault_id  =  data.azurerm_key_vault.kv_applz.id

#       certificate = {
#          contents = var.CERT_APPGW
#          password = var.CERT_PASSWORD
#       }
#       }
#     }
#   }
# }