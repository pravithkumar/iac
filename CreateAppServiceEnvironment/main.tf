module "app_service_environment" {
  source                          = "../Modules/AppServiceEnvironment"
  ase_name                        = var.ase_name
  resource_group_name             = var.resource_group_name
  subnet_id                       = var.subnet_id
  internal_load_balancing_mode    = var.internal_load_balancing_mode
  dns_suffix                      = var.dns_suffix
  disable_tls1_0                  = var.disable_tls1_0
  internal_encryption             = var.internal_encryption
  frontend_ssl_cipher_suite_order = var.frontend_ssl_cipher_suite_order
  tags                            = var.tags
}