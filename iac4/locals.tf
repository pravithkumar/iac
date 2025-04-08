locals {
  app_name     = var.app_name
  environment  = var.environment
  location_test = var.location_test

  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.location_test}-001"
  key_vault_name          = "kv-${local.app_name}-${local.environment}-${local.location_test}-003"

}
