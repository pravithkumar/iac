module "resource_group" {
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/resource-group"
  resource_group_name                 = local.resource_group_name
  location                            = var.location
}

module "azurerm_linux_function_app" {  
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/function-app"
  function_app_name                   = local.function_app_name
  location                            = var.location
  resource_group_name                 = local.resource_group_name
  storage_account_name                = local.storage_account_name_1
  storage_account_resource_group_name = local.resource_group_name
  app_insights_name                   = var.app_insights_name
  app_insights_resource_group_name    = var.app_insights_resource_group_name
  app_service_plan_name               = local.asp_service_plan_name
  runtime                             = var.runtime
  runtime_version                     = var.runtime_version
  https_only                          = true
  always_on                           = var.always_on
  tags                                = var.tags
  depends_on                          = [module.azurerm_service_plan, module.azurerm_storage_account_1]
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
  advanced_threat_protection_enabled    = false
  tags                                  = var.tags
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
  advanced_threat_protection_enabled    = false
  tags                                  = var.tags
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
private_dns_zone_ids                  = [data.azurerm_private_dns_zone.storageaccount1_dns.id]
depends_on                            = [module.azurerm_storage_account_1]
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
  private_dns_zone_ids               = [data.azurerm_private_dns_zone.storageaccount2_dns.id]
  depends_on                         = [module.azurerm_storage_account_2]
}

module "servicebus" {
  providers                         =  {    azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/servicebus"
  resource_group_name               = local.resource_group_name
  location                          = var.location
  servicebus_name                   = local.servicebus_name
  sku                               = var.sku
  enable_managed_identity           = var.enable_managed_identity
  public_network_access_enabled     = false
  trusted_services_allowed          = true
  servicebus_capacity               = var.servicebus_capacity
  premium_messaging_partitions      = var.premium_messaging_partitions
  queue_names                       = var.queue_names
  topic_names                       = var.topic_names
  queue_max_size                    = var.queue_max_size
  topic_max_size                    = var.topic_max_size
  subscription_max_delivery_count   = var.subscription_max_delivery_count
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
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.servicebus_dns.id]
  depends_on                        = [module.servicebus]
}



module "azurerm_key_vault" {  
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                            = "../modules/key-vault"
  azurerm_key_vault_name            = local.key_vault_name
  resource_group_name               = local.resource_group_name
  location                          = var.location  
  enabled_for_disk_encryption       = true
  soft_delete_retention_days        = 7
  purge_protection_enabled          = true
  sku_name                          = "standard"
  enabled_for_template_deployment   = true
  enabled_for_deployment            = true
  enable_rbac_authorization         = true
  public_network_access_enabled     = false
  network_acls                      = []
  tags                              = var.tags
  
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
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.key_vault_dns.id]
  depends_on                        = [module.azurerm_key_vault]
}


module "api_management" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                          = "../modules/api-management"
  api_management_name             = local.api_management_name
  location                        = var.location
  resource_group_name             = local.resource_group_name
  publisher_name                  = var.publisher_name
  publisher_email                 = var.publisher_email
  sku                             = var.api_sku
  sku_count                       = var.sku_count
  tags                            = var.tags
}

module "private_endpoint_api_management" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = "pe-${local.api_management_name}"
  location                        = var.location
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.default_subnet.id
  private_service_connection_name = "${local.api_management_name}-psc"
  private_connection_resource_id  = module.api_management.id
  subresource_names               = ["Gateway"]
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  private_dns_zone_ids            = [data.azurerm_private_dns_zone.api_management_dns.id]  
  depends_on                      = [module.api_management]
}

module "app_service_environment" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                          = "../modules/app-service-environment"
  ase_name                        = local.ase_name
  resource_group_name             = local.resource_group_name
  subnet_id                       = data.azurerm_subnet.delegated_subnet.id
  internal_load_balancing_mode    = var.internal_load_balancing_mode
  disable_tls1_0                  = var.disable_tls1_0
  internal_encryption             = var.internal_encryption
  frontend_ssl_cipher_suite_order = var.frontend_ssl_cipher_suite_order
  enable_managed_identity         = var.enable_managed_identity
  tags                            = var.tags
}

module "app_logic_app" {
  providers                         =  {azurerm = azurerm.integ-nprod-001}
  source                          = "../modules/logic-app"
  resource_group_name             = local.resource_group_name
  app_service_plan_name_1         = local.app_service_plan_name_1
  logic_app_name                  = local.logic_app_name
  os_type                         = "Windows"
  sku_name                        = "I1v2"
  storage_resource_group_name     = local.storage_resource_group_name
  ase_name                        = local.ase_name
  ase_resource_group_name         = local.ase_resource_group_name
  app_service_plan_id             = module.azurerm_service_plan.service_plan_id
  storage_account_name            = local.storage_account_name_1
  storage_account_access_key      = module.azurerm_storage_account_1.primary_access_key
  location                        = var.location
        
 
  enable_managed_identity         = true

   depends_on = [module.app_service_environment,module.azurerm_storage_account_1]
}

