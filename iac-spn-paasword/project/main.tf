module "spn_password" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source = "../modules/spn_password"
  keyvault_name        = var.keyvault_name
  resource_group_name  = var.resource_group_name  
}
