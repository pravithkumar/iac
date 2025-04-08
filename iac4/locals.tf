locals {
  app_name     = var.app_name
  environment  = var.environment
  location_test = var.location_test

 
  key_vault_name          = "kv-${local.app_name}-${local.environment}-${local.location_test}-003"

}
