module "resource_group" {
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/resource-group"
  resource_group_name                 = local.resource_group_name
  location                            = var.location
  tags                                = var.tags
}

module "resource_group_apim" {
  providers                        =  {azurerm = azurerm.dmz}
  source                           = "../modules/resource-group"
  resource_group_name              = local.resource_group_name_apim
  location                         = var.location
  tags                             = var.tags
}

module "azurerm_linux_function_app" {  
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/function-app"
  function_app_name                   = local.function_app_name
  location                            = var.location
  resource_group_name                 = local.resource_group_name
  storage_account_name                = local.storage_account_name_2
  storage_account_resource_group_name = local.resource_group_name
  app_service_plan_name               = local.asp_service_plan_name
  runtime                             = var.runtime
  runtime_version                     = var.runtime_version
  https_only                          = true
  ftps_state                          = "Disabled"
  always_on                           = var.always_on
  tags                                = var.tags
  identity_type                       = "SystemAssigned"
  identity_ids                        = []
  app_settings                        = var.app_settings
  enable_app_insights                 = true
  appinsights_instrumentationkey      = data.azurerm_application_insights.ai.instrumentation_key
  applicationinsights_connectionstring = data.azurerm_application_insights.ai.connection_string
  auth_enabled                         = var.auth_enabled
  allowed_external_redirect_urls       = var.allowed_external_redirect_urls
  client_id                            = var.client_id
  tenant_auth_endpoint                 = var.tenant_auth_endpoint
  minimum_tls_version                  = "1.3"  
  depends_on                           = [module.azurerm_service_plan, module.azurerm_storage_account_2,module.resource_group,module.app_insight]
}

// module "function_app_dns_record" {
//   providers               =  {azurerm = azurerm.shared-dns}
//   source                  = "../modules/dns-record"
//   record_name             = local.function_app_name
//   zone_name               = data.azurerm_private_dns_zone.appservice.name
//   dns_zone_resource_group = data.azurerm_private_dns_zone.appservice.resource_group_name
//   ip_addresses            = module.app_service_environment.internal_ip
// }


module "diagnostic_setting" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/diagnostic-settings"
  enable_monitoring                 = true
  monitor_diagnostic_name           = "diag-${local.function_app_name}"
  target_resource_id                = module.azurerm_linux_function_app.function_app_id
  log_analytics_workspace_id        = data.azurerm_log_analytics_workspace.la.id
  category                          = "FunctionAppLogs"
  depends_on                         = [module.azurerm_linux_function_app]
}

module "role_assignment_storage_contributor" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_storage_account_2.id
  role_definition_name              = "Storage Blob Data Owner"
  principal_id                      = module.azurerm_linux_function_app.principal_id
}

module "role_assignment_fa_kv" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_key_vault.key_vault_id
  role_definition_name              = "Key Vault Secrets User"
  principal_id                      = module.azurerm_linux_function_app.principal_id
}

module "role_assignment_service_bus_sender" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.servicebus.servicebus_id
  role_definition_name              = "Azure Service Bus Data Sender"
  principal_id                      = module.azurerm_linux_function_app.principal_id
}

module "role_assignment_service_bus_recevier" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.servicebus.servicebus_id
  role_definition_name              = "Azure Service Bus Data Receiver"
  principal_id                      = module.azurerm_linux_function_app.principal_id
}

module "azurerm_service_plan" {  
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/app-service-plan"
  resource_group_name                 = local.resource_group_name
  service_plan_name                   = local.asp_service_plan_name
  location                            = var.location
  ase_name                            = local.ase_name
  ase_resource_group_name             = local.ase_resource_group_name
  os_type                             = var.os_type
  aspsku_name                         = var.aspsku_name  
  worker_count                        = var.worker_count
  tags                                = var.tags
  depends_on = [module.resource_group,module.app_service_environment]
}

module "azurerm_storage_account_2" {  
  providers                             =  {azurerm = azurerm.integ-nprod-001}
  source                                = "../modules/storage-account"
  storage_account_name                  = local.storage_account_name_2
  resource_group_name                   = local.resource_group_name
  location                              = var.location
  account_tier                          = var.account_tier
  account_replication_type              = var.account_replication_type
  public_network_access_enabled         = false
  https_traffic_only_enabled            = true
  identity_type                         = "SystemAssigned"
  identity_ids                          = []  
  large_file_share_enabled              = true
  default_to_oauth_authentication       = true
  access_tier                           = "Hot"
  account_kind                          = "StorageV2"
  delete_retention_days                 = 7
  permanent_delete_enabled              = false
  tags                                  = var.tags 
  depends_on                            = [module.resource_group]
}


module "private_endpoint_storage_2" {  
  providers                          =  {azurerm = azurerm.integ-nprod-001}
  source                             = "../modules/private-endpoint"
  private_endpoint_name              = "pe-${local.storage_account_name_2}"
  location                           = var.location
  resource_group_name                = local.resource_group_name
  subnet_id                          = data.azurerm_subnet.default_subnet.id
  private_service_connection_name    = "${local.storage_account_name_2}-psc"
  private_connection_resource_id     = module.azurerm_storage_account_2.id
  subresource_names                  = ["blob"]
  is_manual_connection               = false
  private_dns_zone_group_name        = "private-dns-zone-group"
  tags                                =var.tags
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.storageaccount2_dns.id]
  depends_on                         = [module.azurerm_storage_account_2,module.resource_group]
}

module "app_insight" {
  providers           = { azurerm = azurerm.integ-nprod-001 }
  source              = "../modules/application-insights"
  appinsights_name    = local.appinsights_name
  location            = var.location
  resource_group_name = local.resource_group_name
  law_workspace_id    = data.azurerm_log_analytics_workspace.la.id
  application_type    = "web"
  retention_in_days   = null
  tags                = var.tags
}

module "servicebus" {
  providers                         =  {    azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/service-bus"
  resource_group_name               = local.resource_group_name
  location                          = var.location
  servicebus_name                   = local.servicebus_name
  sku                               = var.sku
  identity_type                     = "SystemAssigned"
  identity_ids                      = []
  public_network_access_enabled     = false
  trusted_services_allowed          = true
  servicebus_capacity               = var.servicebus_capacity
  premium_messaging_partitions      = var.premium_messaging_partitions
  queue_names                       = var.queue_names
  topic_names                       = var.topic_names
  queue_max_size                    = var.queue_max_size
  topic_max_size                    = var.topic_max_size
  minimum_tls_version                  = "1.2"
  tags                                =var.tags
  subscription_max_delivery_count   = var.subscription_max_delivery_count
  depends_on = [module.resource_group]
}

module "private_endpoint_servicebus" {  
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/private-endpoint"
  private_endpoint_name             = "pe-${local.servicebus_name}"
  location                          = var.location
  resource_group_name               = local.resource_group_name
  subnet_id                         = data.azurerm_subnet.default_subnet.id
  private_service_connection_name   = "${local.servicebus_name}-psc"
  private_connection_resource_id    = module.servicebus.servicebus_id
  subresource_names                 = ["namespace"]
  is_manual_connection              = false
  private_dns_zone_group_name       = "private-dns-zone-group"
  tags                                =var.tags
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.servicebus_dns.id]
  depends_on                        = [module.servicebus,module.resource_group]
}

module "role_assignment_servicebus_kv" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_key_vault.key_vault_id
  role_definition_name              = "Key Vault Secrets User"
  principal_id                      = module.servicebus.principal_id
  depends_on                        = [module.servicebus,module.resource_group]
}

module "azurerm_key_vault" {  
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/key-vault"
  azurerm_key_vault_name            = local.key_vault_name
  resource_group_name               = local.resource_group_name
  location                          = var.location  
  enabled_for_disk_encryption       = true
  soft_delete_retention_days        = 7
  purge_protection_enabled          = false
  sku_name                          = "standard"
  enabled_for_template_deployment   = true
  enabled_for_deployment            = true
  enable_rbac_authorization         = true
  public_network_access_enabled     = false
  network_acls                      = []
  tags                              = var.tags
  depends_on = [module.resource_group]
}


module "private_endpoint_key_vault" {  
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/private-endpoint"
  private_endpoint_name             = "pe-${local.key_vault_name}"
  location                          = var.location
  resource_group_name               = local.resource_group_name
  subnet_id                         = data.azurerm_subnet.default_subnet.id
  private_service_connection_name   = "${local.key_vault_name}-psc"
  private_connection_resource_id    = module.azurerm_key_vault.key_vault_id
  subresource_names                 = ["vault"]
  is_manual_connection              = false
  private_dns_zone_group_name       = "private-dns-zone-group"
  tags                                =var.tags
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.key_vault_dns.id]
  depends_on                        = [module.azurerm_key_vault,module.resource_group]
}

// module "spn_password" {
//   providers                         =  {azurerm = azurerm.dmz}
//   source                            = "../modules/spn_password"
//   spn_name                          = "AIP-API-Dev"
//   app_password_display_name         = "AIP-API-Dev-key"
//   password_validity_days            = 180
//   app_kv_secret_name                = "AIP-API-Dev-secret"
//   key_vault_id                      = module.azurerm_key_vault.key_vault_id
//   depends_on                        = [module.azurerm_key_vault]
// }

module "api_management" {
  providers                       =  {azurerm = azurerm.dmz}
  source                          = "../modules/api-management"
  api_management_name             = local.api_management_name
  location                        = var.location
  resource_group_name             = local.resource_group_name_apim
  publisher_name                  = var.publisher_name
  publisher_email                 = var.publisher_email
  sku                             = var.api_sku
  sku_count                       = var.sku_count
  identity_type                   = "SystemAssigned"
  identity_ids                    = []
  app_insights_id                 = data.azurerm_application_insights.ai.id
  app_insights_key                = data.azurerm_application_insights.ai.instrumentation_key
  client_id                       = "ea05543f-733f-43fd-bbe2-857a99c1f2aa"
  client_secret                   = var.client_secret
  allowed_tenants                 = ["5fbc2afc-b6e7-49ed-a6cf-ea49a27f7c12"]
  security_configuration          =var.security_configuration
  tags                            = var.tags
  depends_on                      = [module.resource_group_apim,module.app_insight,module.azurerm_key_vault]
}

module "private_endpoint_api_management" {
  providers                         =  {azurerm = azurerm.dmz}
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = "pe-${local.api_management_name}"
  location                        = var.location
  resource_group_name             = local.resource_group_name_apim
  subnet_id                       = data.azurerm_subnet.apim_pe_subnet.id
  private_service_connection_name = "${local.api_management_name}-psc"
  private_connection_resource_id  = module.api_management.id
  subresource_names               = ["Gateway"]
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  tags                                =var.tags
  private_dns_zone_ids            = [data.azurerm_private_dns_zone.api_management_dns.id]  
  depends_on                      = [module.api_management,module.resource_group_apim]
}

module "apim_gateway_record" {
  providers               =  {azurerm = azurerm.shared-dns}
  source                  = "../modules/dns-record"
  record_name             = "${local.api_management_name}"
  zone_name               = data.azurerm_private_dns_zone.api_management.name
  dns_zone_resource_group = data.azurerm_private_dns_zone.api_management.resource_group_name
  ip_addresses            = [module.private_endpoint_api_management.private_ip_address]
}

module "apim_regional_gateway_record" {
  providers               =  {azurerm = azurerm.shared-dns}
  source                  = "../modules/dns-record"
  record_name             = "${local.api_management_name}-eastus-01.regional"
  zone_name               = data.azurerm_private_dns_zone.api_management.name
  dns_zone_resource_group = data.azurerm_private_dns_zone.api_management.resource_group_name
  ip_addresses            = [module.private_endpoint_api_management.private_ip_address]
}

module "apim_developer_record" {
  providers               =  {azurerm = azurerm.shared-dns}
  source                  = "../modules/dns-record"
  record_name             = "${local.api_management_name}.developer"
  zone_name               = data.azurerm_private_dns_zone.api_management.name
  dns_zone_resource_group = data.azurerm_private_dns_zone.api_management.resource_group_name
  ip_addresses            = [module.private_endpoint_api_management.private_ip_address]
}

module "apim_portal_record" {
  providers               =  {azurerm = azurerm.shared-dns}
  source                  = "../modules/dns-record"
  record_name             = "${local.api_management_name}.portal"
  zone_name               = data.azurerm_private_dns_zone.api_management.name
  dns_zone_resource_group = data.azurerm_private_dns_zone.api_management.resource_group_name
  ip_addresses            = [module.private_endpoint_api_management.private_ip_address]
}

module "apim_management_record" {
  providers               =  {azurerm = azurerm.shared-dns}
  source                  = "../modules/dns-record"
  record_name             = "${local.api_management_name}.management"
  zone_name               = data.azurerm_private_dns_zone.api_management.name
  dns_zone_resource_group = data.azurerm_private_dns_zone.api_management.resource_group_name
  ip_addresses            = [module.private_endpoint_api_management.private_ip_address]
}

module "apim_scm_record" {
  providers               =  {azurerm = azurerm.shared-dns}
  source                  = "../modules/dns-record"
  record_name             = "${local.api_management_name}.scm"
  zone_name               = data.azurerm_private_dns_zone.api_management.name
  dns_zone_resource_group = data.azurerm_private_dns_zone.api_management.resource_group_name
  ip_addresses            = [module.private_endpoint_api_management.private_ip_address]
}


module "diagnostic_setting_api" {
  providers                         =  {azurerm = azurerm.dmz}
  source                            = "../modules/diagnostic-settings"
  enable_monitoring                 = true
  monitor_diagnostic_name           = "diag-${local.api_management_name}"
  target_resource_id                = module.api_management.id
  log_analytics_workspace_id        = data.azurerm_log_analytics_workspace.la.id
  category                          = "GatewayLogs"
  depends_on                        = [module.api_management]
}
module "role_assignment_api_mgmt_kv" {
  providers                         =  {azurerm = azurerm.dmz}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_key_vault.key_vault_id
  role_definition_name              = "Key Vault Secrets User"
  principal_id                      = module.api_management.principal_id
}

module "app_service_environment" {
  providers                       =  {azurerm = azurerm.integ-nprod-001}
  source                          = "../modules/app-service-environment"
  ase_name                        = local.ase_name
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.delegated_subnet.id
  internal_load_balancing_mode    = var.internal_load_balancing_mode
  disable_tls1_0                  = var.disable_tls1_0
  internal_encryption             = var.internal_encryption
  frontend_ssl_cipher_suite_order = var.frontend_ssl_cipher_suite_order
  allow_new_private_endpoint_connections = true
  remote_debugging_enabled        = true
  tags                            = var.tags
  depends_on = [module.resource_group]
}

module "diagnostic_setting_appservice" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/diagnostic-settings"
  enable_monitoring                 = true
  monitor_diagnostic_name           = "diag-${local.ase_name}"
  target_resource_id                = module.app_service_environment.id
  log_analytics_workspace_id        = data.azurerm_log_analytics_workspace.la.id
  category                          = "AppServiceEnvironmentPlatformLogs"
  depends_on                        = [module.app_service_environment]
}

module "app_logic_app" {
  providers                       =  {azurerm = azurerm.integ-nprod-001}
  source                          = "../modules/logic-app"
  resource_group_name             = local.resource_group_name
  app_service_plan_name_1         = local.app_service_plan_name
  logic_app_name                  = local.logic_app_name
  os_type                         = "Linux"
  sku_name                        = "I1v2"
  storage_resource_group_name     = local.storage_resource_group_name
  ase_name                        = local.ase_name
  ase_resource_group_name         = local.ase_resource_group_name
  storage_account_name            = local.storage_account_name_1
  storage_account_access_key      = module.azurerm_storage_account_1.primary_access_key
  location                        = var.location
  identity_type                   = "SystemAssigned"
  identity_ids                    = []
  https_only                      = true
  enable_app_insights             = true
  min_tls_version                 = "1.2"
  appinsights_instrumentationkey  = data.azurerm_application_insights.ai.instrumentation_key
  applicationinsights_connectionstring = data.azurerm_application_insights.ai.connection_string 
  tags                            = var.tags
  depends_on                      = [module.app_service_environment,module.azurerm_storage_account_1,module.resource_group,module.app_insight]
}

// module "logic_app_dns_record" {
//   providers               =  {azurerm = azurerm.shared-dns}
//   source                  = "../modules/dns-record"
//   record_name             = local.logic_app_name
//   zone_name               = data.azurerm_private_dns_zone.appservice.name
//   dns_zone_resource_group = data.azurerm_private_dns_zone.appservice.resource_group_name
//   ip_addresses            = module.app_service_environment.internal_ip
// }

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
  large_file_share_enabled              = true
  default_to_oauth_authentication       = true
  access_tier                           = "Hot"
  account_kind                          = "StorageV2"
  delete_retention_days                 = 7
  permanent_delete_enabled              = false
  tags                                  = var.tags  
  depends_on = [module.resource_group]
}

module "private_endpoint_storage_1" {  
  providers                             =  {azurerm = azurerm.integ-nprod-001}
  source                                = "../modules/private-endpoint"
  private_endpoint_name                 = "pe-${local.storage_account_name_1}"
  location                              = var.location
  resource_group_name                   = local.resource_group_name
  subnet_id                             = data.azurerm_subnet.default_subnet.id
  private_service_connection_name       = "${local.storage_account_name_1}-psc"
  private_connection_resource_id        = module.azurerm_storage_account_1.id
  subresource_names                     = ["blob"]
  is_manual_connection                  = false
  private_dns_zone_group_name           = "private-dns-zone-group"
  tags                                  = var.tags
  private_dns_zone_ids                  = [data.azurerm_private_dns_zone.storageaccount1_dns.id]
  depends_on                            = [module.azurerm_storage_account_1,module.resource_group]
}

module "diagnostic_setting_logicapp" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/diagnostic-settings"
  enable_monitoring                 = true
  monitor_diagnostic_name           = "diag-${local.logic_app_name}"
  target_resource_id                = module.app_logic_app.id
  log_analytics_workspace_id        = data.azurerm_log_analytics_workspace.la.id
  category                          = "WorkflowRuntime"
  depends_on                         = [module.app_logic_app]
}

module "role_assignment_logic_app_stg" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_storage_account_1.id
  role_definition_name              = "Storage Blob Data Contributor"
  principal_id                      = module.app_logic_app.principal_id
}

module "role_assignment_logic_app_kv" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_key_vault.key_vault_id
  role_definition_name              = "Key Vault Secrets User"
  principal_id                      = module.app_logic_app.principal_id
}

module "role_assignment_spn_kv" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/role_assignments"
  scope                             = module.azurerm_key_vault.key_vault_id
  role_definition_name              = "Key Vault Secrets Officer"
  principal_id                      = "d52c935e-7cc6-4845-b624-78664f0b271b"
}