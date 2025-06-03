module "avd_deployment" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source = "../modules/spn_password"
  keyvault_name        = var.keyvault_name
  resource_group_name  = var.resource_group_name
  app_password_display_name =var.app_password_display_name
  app_kv_secret_name        =var.app_kv_secret_name
  spn_name                  =var.spn_name
  password_validity_days    =var.password_validity_days
}
