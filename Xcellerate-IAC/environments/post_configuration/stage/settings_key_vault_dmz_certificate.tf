 locals {
   configure_kv_dmz_certificate = {

    settings = {

      # "rbqm-certificate" = {
      #   name          = var.CERT_RBQM-STG
      #   key_vault_id  =  data.azurerm_key_vault.kv_dmz.id

      #   certificate = {
      #   contents = var.
      #   password = var.CERT_PASSWORD
      #   }
      # }

      "agw-certificate" = {
        name          = "cert-int-xl-stg-eastus-agw"
        key_vault_id  =  data.azurerm_key_vault.kv_dmz.id

        certificate = {
        contents = var.CERT_APPGW
        password = var.CERT_PASSWORD
        }
      }
     }
   }
 }