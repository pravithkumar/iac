locals {
  app_name     = var.app_name
  environment  = var.environment
  location_test = var.location_test
  storage_resource_group_name  = "rg-${local.app_name}-${local.environment}-${local.location_test}-005"
  app_service_plan_name        = "asp-${local.app_name}-${local.environment}-${local.location_test}-005"

  function_app_name       = "fa-${local.app_name}-${local.environment}-${local.location_test}-005"  
  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.location_test}-005"
  asp_service_plan_name   = "asp-${local.app_name}-${local.environment}-${local.location_test}-005"
  storage_account_name_1  = "stg${local.app_name}${local.environment}${local.location_test}005"
} 
