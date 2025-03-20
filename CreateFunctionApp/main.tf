# main.tf

module "function_app_and_pe" {
  source                                = "../Modules/AzureFunctionApp"
  function_app_name                     = var.function_app_name
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  storage_account_name                  = var.storage_account_name
  storage_account_resource_group_name   = var.storage_account_resource_group_name
  app_insights_name                     = var.app_insights_name
  app_insights_resource_group_name      = var.app_insights_resource_group_name
  app_service_plan_name                 = var.app_service_plan_name
  runtime                               = var.runtime
  runtime_version                       = var.runtime_version
  https_only                            = var.https_only
  always_on                             = var.always_on
  tags                                  = var.tags
  private_endpoint_subnet_id            = var.private_endpoint_subnet_id
  private_dns_zone_id                   = var.private_dns_zone_id
}

resource "azurerm_service_plan" "asp" {
  provider            = azurerm.aiml-nprod-001
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.aspsku_name
  worker_count        = var.worker_count
  tags                = var.tags
}