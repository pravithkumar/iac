provider "azurerm" {
  features {}  
}

module "azurerm_linux_function_app" {
  source                              = "../modules/function-app"
  function_app_name                   = var.function_app_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  storage_account_name                = var.storage_account_name
  storage_account_resource_group_name = var.storage_account_resource_group_name
  app_insights_name                   = var.app_insights_name
  app_insights_resource_group_name    = var.app_insights_resource_group_name
  app_service_plan_name               = var.asp_service_plan_name
  runtime                             = var.runtime
  runtime_version                     = var.runtime_version
  https_only                          = var.https_only
  always_on                           = var.always_on
  tags                                = var.tags
  depends_on                          = [module.azurerm_service_plan]
}

module "azurerm_service_plan" {
  source                              = "../modules/app-service-plan"
  resource_group_name                 = var.asp_resource_group_name
  location                            = var.location
  os_type                             = var.os_type
  aspsku_name                         = var.aspsku_name
  service_plan_name                   = var.asp_service_plan_name
  worker_count                        = var.worker_count
  tags                                = var.tags
}

module "private_endpoint_function_app" {
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = var.private_endpoints[0].name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  subnet_id                       = var.private_endpoints[0].subnet_id
  private_service_connection_name = "${var.function_app_name}-psc"
  private_connection_resource_id  = module.azurerm_linux_function_app.function_app_id
  subresource_names               = var.private_endpoints[0].subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  private_dns_zone_ids            = var.private_endpoints[0].private_dns_zone_ids
  depends_on                      = [module.azurerm_linux_function_app]
}

module "storage" {
  source                          = "../modules/storage-account"
  resource_group_name             = var.resource_group_name
  storage_account_name            = var.storage_account_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  tags                            = var.tags
}

module "servicebus" {
  source                = "../modules/servicebus"
  resource_group_name   = var.resource_group_name
  location              = var.location
  servicebus_name       = var.servicebus_name
  sku                   = var.sku
}

module "private_endpoint_servicebus" {
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = var.private_endpoints[1].name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  subnet_id                       = var.private_endpoints[1].subnet_id
  private_service_connection_name = "${var.servicebus_name}-psc"
  private_connection_resource_id  = module.servicebus.servicebus_id
  subresource_names               = var.private_endpoints[1].subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  private_dns_zone_ids            = var.private_endpoints[1].private_dns_zone_ids
  depends_on                      = [module.servicebus]
}

module "azurerm_key_vault" {
  source                              = "../modules/key-vault"
  key_vault_name                      = var.key_vault_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name 
  sku_name                            = var.kvsku_name
  kvpurge_protection_enabled           = var.kvpurge_protection_enabled
  kvrbac_authorization                 = var.kvrbac_authorization
  kvsoft_delete_retention_days         = var.kvsoft_delete_retention_days
  enabledfordeployment                 = var.enabledfordeployment
  enabledfordiskencryption         = var.enabled_for_disk_encryption
  enabledfortemplatedeployment     = var.enabled_for_template_deployment
  kvnetdefaultaction                  = var.kvnetdefaultaction
  kvnetaclbypass                      = var.kvnetaclbypass
  kvip_rules                          = var.kvip_rules
  kvtimeoutcreate                     = var.kvtimeoutcreate
  kvtimeoutupdate                     = var.kvtimeoutupdate
  kvtimeoutdelete                     = var.kvtimeoutdelete
  tags                                = var.tags
}
