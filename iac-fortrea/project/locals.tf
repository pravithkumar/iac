locals {
  app_name     = var.app_name
  environment  = var.environment
  location_test = var.location_test

  logic_app_name               = "la-${local.app_name}-${local.environment}-${local.location_test}-001" 
  app_service_plan_name        = "asp-${local.app_name}-${local.environment}-${local.location_test}-002" 
  // ase_name                     = "ase-${local.app_name}-${local.environment}-${local.location_test}-001"

  api_management_name          = "api-${local.app_name}-${local.environment}-${local.location_test}-002"

  // ase_resource_group_name      = "rg-${local.app_name}-${local.environment}-${local.location_test}-002" 
  storage_resource_group_name  = "rg-${local.app_name}-${local.environment}-${local.location_test}-002"


  function_app_name       = "fa-${local.app_name}-${local.environment}-${local.location_test}-002"  
  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.location_test}-002"
  asp_service_plan_name   = "asp-${local.app_name}-${local.environment}-${local.location_test}-001"
  servicebus_name         = "sb-${local.app_name}-${local.environment}-${local.location_test}-002"
  key_vault_name          = "kv-${local.app_name}-${local.environment}-${local.location_test}-002"
  storage_account_name_1  = "stg${local.app_name}${local.environment}${local.location_test}002"
  storage_account_name_2  = "stg${local.app_name}${local.environment}${local.location_test}003"
  monitor_diagnostic_name_1 = "mds-${local.app_name}-${local.environment}-${local.location_test}-001"
  monitor_diagnostic_name_2 = "mds-${local.app_name}-${local.environment}-${local.location_test}-006"
}
