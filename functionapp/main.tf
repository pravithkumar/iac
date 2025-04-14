module "resource_group" {
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/resource-group"
  resource_group_name                 = local.resource_group_name
  location                            = var.location
  tags                                  = var.tags
}

module "azurerm_linux_function_app" {  
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/function-app"
  function_app_name                   = local.function_app_name
  location                            = var.location
  resource_group_name                 = local.resource_group_name
  storage_account_name                = local.storage_account_name_1
  storage_account_resource_group_name = local.resource_group_name
  app_service_plan_name               = local.asp_service_plan_name
  runtime                             = var.runtime
  runtime_version                     = var.runtime_version
  https_only                          = true
  always_on                           = var.always_on
  tags                                = var.tags
  identity_type                       = "SystemAssigned"
  identity_ids                        = []
  app_settings                        = var.app_settings
  enable_app_insights                 = true
  appinsights_instrumentationkey      = data.azurerm_application_insights.ai.instrumentation_key
  applicationinsights_connectionstring = data.azurerm_application_insights.ai.connection_string
  depends_on                          = [module.azurerm_service_plan, module.azurerm_storage_account_1,module.resource_group]
}

module "private_endpoint_function_app" {  
  providers                          =  {azurerm = azurerm.integ-nprod-001}
  source                             = "../modules/private-endpoint"
  private_endpoint_name              = "pe-${local.function_app_name}"
  location                           = var.location
  resource_group_name                = local.resource_group_name
  subnet_id                          = data.azurerm_subnet.default_subnet.id
  private_service_connection_name    = "${local.function_app_name}-psc"
  private_connection_resource_id     = module.azurerm_linux_function_app.function_app_id
  subresource_names                  = ["sites"]
  is_manual_connection               = false
  private_dns_zone_group_name        = "private-dns-zone-group"
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.function_app_dns.id]
  depends_on                         = [module.azurerm_linux_function_app]
}

module "azurerm_service_plan" {  
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/app-service-plan"
  resource_group_name                 = local.resource_group_name
  service_plan_name                   = local.asp_service_plan_name
  location                            = var.location
  os_type                             = var.os_type
  aspsku_name                         = var.aspsku_name  
  worker_count                        = var.worker_count
  tags                                = var.tags
  depends_on                          = [module.resource_group]
}

module "diagnostic_setting" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/diagnostic-settings"
  enable_monitoring                 = true
  monitor_diagnostic_name           = local.monitor_diagnostic_name
  target_resource_id                = module.azurerm_linux_function_app.function_app_id
  log_analytics_workspace_id        = data.azurerm_log_analytics_workspace.la.id
  depends_on                         = [module.azurerm_linux_function_app]
}

module "role_assignment_storage_contributor" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_storage_account_1.id
  role_definition_name              = "Storage Account Contributor"
  principal_id                      = module.azurerm_linux_function_app.principal_id
}

module "azurerm_storage_account_1" {  
  providers                             =  {azurerm = azurerm.integ-nprod-001}
  source                                = "../modules/storage-account"
  storage_account_name                  = local.storage_account_name_1
  resource_group_name                   = local.resource_group_name
  location                              = var.location
  account_tier                          = var.account_tier
  account_replication_type              = var.account_replication_type
  public_network_access_enabled         = false
  https_traffic_only_enabled            = true
  identity_type                         = "SystemAssigned"
  identity_ids                          = []
  advanced_threat_protection_enabled    = false
  tags                                  = var.tags
  depends_on                          = [module.resource_group]
}