# main.tf

resource "azurerm_function_app" "function_app" {
  source                     = "./modules/function_app"
  function_app_name          = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_resource_group_name = var.storage_account_resource_group_name
  app_insights_name          = var.app_insights_name
  app_insights_resource_group_name = var.app_insights_resource_group_name
  runtime                    = var.runtime
  runtime_version            = var.runtime_version
  https_only                 = var.https_only
  always_on                  = var.always_on
  tags                       = var.tags
}

resource "azurerm_private_endpoint" "function_app_pe" {
  source                     = "./modules/private_endpoint"
  private_endpoint_name      = "${var.function_app_name}-pe"
  location                   = var.location
  resource_group_name        = var.resource_group_name
  subnet_id                  = var.private_endpoint_subnet_id
  function_app_id            = azurerm_function_app.function_app.id
  private_dns_zone_id        = var.private_dns_zone_id
  tags                       = var.tags
}