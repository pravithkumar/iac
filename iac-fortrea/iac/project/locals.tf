locals {
  app_name     = var.app_name
  environment  = var.environment
  region = var.region

  logic_app_name               = "lapp-${local.app_name}-${local.environment}-${local.region}-001" 
  app_service_plan_name        = "asp-${local.app_name}-${local.environment}-${local.region}-001" 
  ase_name                     = "ase-${local.app_name}-${local.environment}-${local.region}-001"

  api_management_name          = "api-${local.app_name}-${local.environment}-${local.region}-001"
  resource_group_name_apim     = "rg-${local.app_name}-${local.environment}-${local.region}-000"

  ase_resource_group_name      = "rg-${local.app_name}-${local.environment}-${local.region}-001" 
  storage_resource_group_name  = "rg-${local.app_name}-${local.environment}-${local.region}-001"


  function_app_name       = "func-${local.app_name}-${local.environment}-${local.region}-001"  
  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.region}-001"
  asp_service_plan_name   = "asp-${local.app_name}-${local.environment}-${local.region}-002"
  servicebus_name         = "sb-${local.app_name}-${local.environment}-${local.region}-001"
  key_vault_name          = "kv-${local.app_name}-${local.environment}-${local.region}-001"
  storage_account_name_1  = "st${local.app_name}${local.environment}${local.region}001"
  storage_account_name_2  = "st${local.app_name}${local.environment}${local.region}002"
  appinsights_name        = "ai-${local.app_name}-${local.environment}-${local.region}-001"

  monitor_diagnostic_name_1 = "mds-${local.app_name}-${local.environment}-${local.region}-001"
}
