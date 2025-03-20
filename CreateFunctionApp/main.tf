# Calling the Azure Function App Module
module "function_app_and_pe" {
  source                              = "../Modules/AzureFunctionApp"
  function_app_name                   = var.function_app_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  storage_account_name                = var.storage_account_name
  storage_account_resource_group_name = var.storage_account_resource_group_name
  app_insights_name                   = var.app_insights_name
  app_insights_resource_group_name    = var.app_insights_resource_group_name
  app_service_plan_name               = var.app_service_plan_name
  runtime                             = var.runtime
  runtime_version                     = var.runtime_version
  https_only                          = var.https_only
  always_on                           = var.always_on
  tags                                = var.tags
  private_endpoint_subnet_id          = var.private_endpoint_subnet_id
  private_dns_zone_id                 = var.private_dns_zone_id
}

# Calling the Private Endpoint Module for the Function App
module "function_app_pe" {
  source                      = "../Modules/private-endpoint"
  function_app_name           = module.function_app_and_pe.function_app_name
  location                    = module.function_app_and_pe.location
  resource_group_name         = module.function_app_and_pe.resource_group_name
  private_endpoint_subnet_id  = var.private_endpoint_subnet_id
  private_dns_zone_name       = var.function_app_private_dns_zone_name
  function_app_id             = module.function_app_and_pe.function_app_name
  virtual_network_id          = data.azurerm_virtual_network.existing_vnet.id
}
