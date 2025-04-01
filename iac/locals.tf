locals {
  app_name     = var.app_name
  environment  = var.environment
  location     = var.location

  function_app_name       = "fa-${local.app_name}-${local.environment}-${local.location}-001"
  resource_group_name     = "rg-${local.app_name}-${local.environment}-${local.location}-001"
  service_plan_name       = "asp-${local.app_name}-${local.environment}-${local.location}-001"
  private_endpoint_name   = "pe-${local.app_name}-${local.environment}-${local.location}-001"
  storage_account_name    = "stg${local.app_name}${local.environment}${local.location}001"
  servicebus_name         = "sb-${local.app_name}-${local.environment}-${local.location}-001"
  key_vault_name          = "kv-${local.app_name}-${local.environment}-${local.location}-001"
}
