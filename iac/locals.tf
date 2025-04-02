locals {
  app_name     = var.app_name
  environment  = var.environment
  location_test = var.location_test
  function_app_name       = "fa-${local.app_name}-${local.environment}-${local.location_test}-001"  
  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.location_test}-001"
  asp_service_plan_name       = "asp-${local.app_name}-${local.environment}-${local.location_test}-001"
  servicebus_name         = "sb-${local.app_name}-${local.environment}-${local.location_test}-001"
  key_vault_name          = "kv-${local.app_name}-${local.environment}-${local.location_test}-001"
  storage_account_name_1  = "stg${local.app_name}${local.environment}${local.location_test}001"
  storage_account_name_2  = "stg${local.app_name}${local.environment}${local.location_test}002"
}
