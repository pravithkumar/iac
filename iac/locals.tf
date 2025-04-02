locals {
  app_name     = var.app_name
  environment  = var.environment
  location-test     = var.location-test
  function_app_name       = "fa-${local.app_name}-${local.environment}-${local.location-test}-001"  
  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.location-test}-001"
}
