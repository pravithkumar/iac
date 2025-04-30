module "spn_password" {
  source = "../modules/spn_password"
  providers            =  {azurerm = azurerm.integ-nprod-001}
  keyvault_name        = var.keyvault_name
  resource_group_name  = var.resource_group_name  
}
