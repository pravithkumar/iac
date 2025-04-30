module "spn_password" {
  source = "../modules/spn_password"
  service_principal_id = var.service_principal_id
  keyvault_name        = var.keyvault_name
  resource_group_name  = var.resource_group_name  
}
