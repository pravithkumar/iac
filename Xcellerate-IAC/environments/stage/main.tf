#module to deploy the Resource Group
module "resource_group_1" {
  source = "../../modules/resource_group"
  providers = {
    azurerm = azurerm.applz
  }
  resource_group_name = var.rg1_resource_group_name
  location            = var.rg1_location
  tags                = var.tags
}

module "resource_group_3" {
  source = "../../modules/resource_group"
  providers = {
    azurerm = azurerm.dmz
  }
  resource_group_name = var.rg3_resource_group_name
  location            = var.rg3_location
  tags                = var.tags
}

#module to deploy the NSG
module "network_security_group_prod" {
  for_each = local.configure_nsg_prod_resources.settings
  source   = "../../modules/nsg"
  providers = {
    azurerm = azurerm.applz
  }
  settings = each.value
}

module "network_security_group_dmz" {
  for_each = local.configure_nsg_dmz_resources.settings
  source   = "../../modules/nsg"
  providers = {
    azurerm = azurerm.dmz
  }
  settings   = each.value
  depends_on = [module.resource_group_3]
}

#module to deploy the User Managed Identity
module "managed_identity" {
  for_each = local.configure_uai_resources.settings
  source   = "../../modules/managed_identity"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

#module to deploy the Key Vault
module "key_vault_prod" {
  for_each = local.configure_kv_prod_resources.settings
  source   = "../../modules/keyvault"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

module "key_vault_dmz" {
  for_each = local.configure_kv_dmz_resources.settings
  source   = "../../modules/keyvault"
  providers = {
    azurerm = azurerm.dmz
  }
  settings   = each.value
  depends_on = [module.resource_group_3]
}

#module to deploy the ACR
module "acr" {
  for_each = local.configure_acr_resources.settings
  source   = "../../modules/acr"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

#module to deploy the SQL Server
module "sql" {
  for_each = local.configure_mssql_resources.settings
  source   = "../../modules/mssql"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1, module.managed_identity]
}

#module to deploy the Redis Cache
module "redis_cache" {
  for_each = local.configure_redis_resources.settings
  source   = "../../modules/redis_cache"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

#module to deploy the AKS Cluster
module "aks" {
  for_each = local.configure_aks_resources.settings
  source   = "../../modules/aks"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1, module.role_assignment_shared_services, module.role_assignment_prod]
}

#module to deploy the API Management
module "apim" {
  for_each = local.configure_apim_resources.settings
  source   = "../../modules/apim"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

#module to deploy the Public IP for App Gateway
module "public_ip" {
  for_each = local.configure_public_ip_resources.settings
  source   = "../../modules/public_ip"
  providers = {
    azurerm = azurerm.dmz
  }
  settings   = each.value
  depends_on = [module.resource_group_3]
}

#module to deploy the Application Gateway
module "application_gateway" {
  for_each = local.configure_appgw_resources.settings
  source   = "../../modules/application_gateway"
  providers = {
    azurerm.dmz = azurerm.dmz
  }
  settings   = each.value
  depends_on = [module.resource_group_3]
}

#module to deploy the role base management
module "role_assignment_prod" {
  for_each = local.configure_role_assignment_prod.settings
  source   = "../../modules/role_assignment"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.key_vault_prod]
}

module "role_assignment_dmz" {
  for_each = local.configure_role_assignment_dmz.settings
  source   = "../../modules/role_assignment"
  providers = {
    azurerm = azurerm.dmz
  }
  settings   = each.value
  depends_on = [module.key_vault_dmz]
}

module "role_assignment_shared_services" {
  for_each = local.configure_role_assignment_shared_services.settings
  source   = "../../modules/role_assignment"
  providers = {
    azurerm = azurerm.shared_services
  }
  settings = each.value
}

#module to deploy the storage account
module "storage_account" {
  for_each = local.configure_storage_account_resources.settings
  source   = "../../modules/storage_account"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

#module to deploy the diagnostic settings
module "diag_settings_prod" {
  for_each = local.configure_diag_settings_resources.settings
  source   = "../../modules/diagnostic_settings"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.acr, module.aks, module.redis_cache, module.apim, module.application_insights_prod]
}

module "diag_settings_dmz" {
  for_each = local.configure_diag_settings_dmz_resources.settings
  source   = "../../modules/diagnostic_settings"
  providers = {
    azurerm = azurerm.dmz
  }
  settings   = each.value
  depends_on = [module.application_gateway]
}

#module to deploy application insights
module "application_insights_prod" {
  for_each = local.configure_ai_resources.settings
  source   = "../../modules/appinsights"
  providers = {
    azurerm = azurerm.applz
  }
  settings   = each.value
  depends_on = [module.resource_group_1]
}

#module to deploy route table
module "route_table_prod" {
  for_each = local.configure_udr_prod.settings
  source   = "../../modules/route_table"
  providers = {
    azurerm = azurerm.applz
  }
  settings = each.value
}

module "route_table_dmz" {
  for_each = local.configure_udr_dmz.settings
  source   = "../../modules/route_table"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#module to deploy resource lock
module "resource_lock" {
  for_each = local.configure_resource_lock.settings
  source   = "../../modules/resource_lock"
  providers = {
    azurerm = azurerm.dmz
  }
  name          = each.value.name
  resourceScope = each.value.resourceScope
  depends_on    = [module.public_ip]
}

