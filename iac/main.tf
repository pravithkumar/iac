module "azurerm_linux_function_app" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                              = "../modules/function-app"
  function_app_name                   = local.function_app_name
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
  depends_on                          = [module.azurerm_service_plan, module.azurerm_storage_account]
}

module "private_endpoint_function_app" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = "pe-${var.function_app_name}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  private_endpoint = {
    subnet_id            = data.azurerm_subnet.default_subnet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone.function_app_dns.id]
  }
  private_service_connection_name = "${var.function_app_name}-psc"
  private_connection_resource_id  = module.azurerm_linux_function_app.function_app_id
  subresource_names               = var.private_endpoints[0].subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  depends_on                      = [module.azurerm_linux_function_app]
}

module "azurerm_service_plan" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                              = "../modules/app-service-plan"
  resource_group_name                 = var.asp_resource_group_name
  location                            = var.location
  os_type                             = var.os_type
  aspsku_name                         = var.aspsku_name
  service_plan_name                   = var.asp_service_plan_name
  worker_count                        = var.worker_count
  tags                                = var.tags
}

module "azurerm_storage_account" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  for_each                = { for sa in var.storage_accounts : sa.name => sa }
  source                  = "../modules/storage-account"
  storage_account_name    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  account_tier            = each.value.account_tier
  account_replication_type = each.value.account_replication
  public_network_access_enabled = each.value.public_network_access_enabled
  https_traffic_only_enabled = each.value.https_traffic_only_enabled
  identity_type           = each.value.identity_type
  advanced_threat_protection_enabled = each.value.advanced_threat_protection_enabled
  tags                    = var.tags
}

module "private_endpoint_storage" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  for_each                        = { for sa in var.storage_accounts : sa.name => sa }
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = "pe-${each.value.name}"
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  private_endpoint = {
    subnet_id            = data.azurerm_subnet.default_subnet.id
    private_dns_zone_ids = [data.azurerm_private_dns_zone[each.key + "_dns"].id]
  }
  private_service_connection_name = "${each.value.name}-psc"
  private_connection_resource_id  = module.azurerm_storage_account[each.key].id
  subresource_names               = each.value.subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  depends_on                      = [module.azurerm_storage_account]
}

module "servicebus" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                = "../modules/servicebus"
  resource_group_name   = var.resource_group_name
  location              = var.location
  servicebus_name       = var.servicebus_name
  enable_managed_identity = var.enable_managed_identity
  public_network_access_enabled = var.public_network_access_enabled
  trusted_services_allowed      = var.trusted_services_allowed
  sku                   = var.sku
}

module "private_endpoint_servicebus" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = "pe-${var.servicebus_name}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  subnet_id                       = data.azurerm_subnet.default_subnet.id
  private_service_connection_name = "${var.servicebus_name}-psc"
  private_connection_resource_id  = module.servicebus.servicebus_id
  subresource_names               = var.private_endpoints[1].subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  private_dns_zone_ids            = [data.azurerm_private_dns_zone.servicebus_dns.id]
  depends_on                      = [module.servicebus]
}


module "azurerm_key_vault" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                              = "../modules/key-vault"
  key_vault_name                      = var.key_vault_name
  location                            = var.location
  resource_group_name                 = var.resource_group_name 
  kvskuname                            = var.kvsku_name
  kvpurge_protection_enabled           = var.kvpurge_protection_enabled
  kvrbac_authorization                 = var.kvrbac_authorization
  kvsoft_delete_retention_days         = var.kvsoft_delete_retention_days
  enabled_for_deployment                 = var.enabled_for_deployment
  enabledfordiskencryption         = var.enabled_for_disk_encryption
  enabledfortemplatedeployment     = var.enabled_for_template_deployment
  public_network_access_enabled    = var.public_network_access_enabled
  kvnetdefaultaction                  = var.kvnetdefaultaction
  kvnetaclbypass                      = var.kvnetaclbypass
  kvip_rules                          = var.kvip_rules
  kvtimeoutcreate                     = var.kvtimeoutcreate
  kvtimeoutupdate                     = var.kvtimeoutupdate
  kvtimeoutdelete                     = var.kvtimeoutdelete
  tags                                = var.tags
}
module "private_endpoint_key_vault" {  
  providers = {
    azurerm = azurerm.integ-nprod-001
  }
  source                          = "../modules/private-endpoint"
  private_endpoint_name           = "pe-${var.key_vault_name}"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  subnet_id                       = data.azurerm_subnet.default_subnet.id
  private_service_connection_name = "${var.key_vault_name}-psc"
  private_connection_resource_id  = module.azurerm_key_vault.key_vault_id
  subresource_names               = var.private_endpoints[2].subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  private_dns_zone_ids            = [data.azurerm_private_dns_zone.key_vault_dns.id]
  depends_on                      = [module.azurerm_key_vault]
}

