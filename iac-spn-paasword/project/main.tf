module "spn_password" {
  source = "../modules/spn_password"
  keyvault_name        = var.keyvault_name
  resource_group_name  = var.resource_group_name  
}
