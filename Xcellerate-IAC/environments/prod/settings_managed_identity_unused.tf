# locals {
#   configure_uai_resources = {
#     settings = {

#       "mi-${var.app_name}-${var.environment}-${var.location}-001" = {
#         resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
#         name                = "mi-${var.app_name}-${var.environment}-${var.location}-001"
#         location            = var.location
#         tags                = var.tags
#         role_assignment     = [
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Key Vault Administrator"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Key Vault Crypto Service Encryption User"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Key Vault Crypto Officer"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Key Vault Secrets User"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "acrpull"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Network Contributor"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "acrpush"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Private DNS Zone Contributor"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Storage Account Key Operator Service Role"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Storage Blob Data Contributor"
#           },
#           {
#             scope                = "/subscriptions/${data.azurerm_client_config.this.subscription_id}"
#             role_definition_name = "Contributor"
#           }
#         ]
#       }

#   }
# }
