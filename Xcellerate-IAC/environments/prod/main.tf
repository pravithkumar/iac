#module to deploy the Resource Group
module "resource_group_1" {
  source              = "../../modules/resource_group"
  providers           = { azurerm.prod = azurerm.prod }
  resource_group_name = var.rg1_resource_group_name
  location            = var.rg1_location
  tags                = var.tags
}

# module "resource_group_2" {
#   source              = "../../modules/resource_group"
#   providers           = { azurerm.prod = azurerm.prod }
#   resource_group_name = var.rg2_resource_group_name
#   location            = var.rg2_location
#   tags                = var.tags
# }

module "resource_group_3" {
  source              = "../../modules/resource_group"
  providers           = { azurerm.dmz = azurerm.dmz }
  resource_group_name = var.rg3_resource_group_name
  location            = var.rg3_location
  tags                = var.tags
}

#module to deploy the Vnet
# module "virtual_network_prod" {
#   source              = "../../modules/vnet"
#   providers           = { azurerm.prod = azurerm.prod }
#   location            = var.rg2_location
#   resource_group_name = var.rg2_resource_group_name
#   vnet_name           = var.vnet_name
#   address_space       = var.address_space
#   subnet_prefixes     = var.subnet_prefixes
#   subnet_names        = var.subnet_names
#   tags                = var.tags
#   depends_on          = [module.resource_group_2]
# }

#module to deploy the NSG
module "network_security_group_prod" {
  for_each = local.configure_nsg_prod_resources.settings
  source   = "../../modules/nsg"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

module "network_security_group_dmz" {
  for_each = local.configure_nsg_dmz_resources.settings
  source   = "../../modules/nsg"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#module to deploy the User Managed Identity
module "managed_identity" {
  source              = "../../modules/user_managed_identity"
  providers           = { azurerm.prod = azurerm.prod }
  resource_group_name = var.rg1_resource_group_name
  identity_name       = var.identity_name
  location            = var.rg1_location
  tags                = var.tags
  depends_on          = [module.resource_group_1]
}

# module "managed_identity" {
#   for_each = local.configure_uai_resources.settings
#   source              = "../../modules/managed_identity"
#   providers           = { 
#     azurerm = azurerm.prod 
#     }
#   settings = each.value
# }

#module to deploy the Key Vault
module "key_vault_prod" {
  for_each = local.configure_kv_prod_resources.settings
  source   = "../../modules/keyvault"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

module "key_vault_dmz" {
  for_each = local.configure_kv_dmz_resources.settings
  source   = "../../modules/keyvault"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#module to deploy the ACR
module "acr" {
  for_each = local.configure_acr_resources.settings
  source   = "../../modules/acr"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

#module to deploy the SQL Server
module "sql" {
  for_each = local.configure_mssql_resources.settings
  source   = "../../modules/mssql"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

#module to deploy the Redis Cache
module "redis_cache" {
  for_each = local.configure_redis_resources.settings
  source   = "../../modules/redis_cache"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

#module to deploy the AKS Cluster
module "aks" {
  for_each = local.configure_aks_resources.settings
  source   = "../../modules/aks"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
  # depends_on = [module.role_assignment_shared_services]
}

# #module to deploy the API Management
module "apim" {
  for_each = local.configure_apim_resources.settings
  source   = "../../modules/apim"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

#module to deploy the Public IP for App Gateway
module "public_ip" {
  for_each = local.configure_public_ip_resources.settings
  source   = "../../modules/public_ip"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#module to deploy the Application Gateway
module "application_gateway" {
  for_each = local.configure_appgw_resources.settings
  source   = "../../modules/application_gateway"
  providers = {
    azurerm.dmz = azurerm.dmz
  }
  settings = each.value
}

#module to deploy the Azure FrontDoor
module "frontdoor" {
  for_each = local.configure_frontdoor_resources.settings
  source   = "../../modules/frontdoor"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#module to deploy the role base management
module "role_assignment_prod" {
  for_each = local.configure_role_assignment_prod.settings
  source   = "../../modules/role_assignment"
  providers = {
    azurerm = azurerm.prod
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
  settings   = each.value
  depends_on = [module.aks]
}

#module to deploy the storage account
module "storage_account" {
  for_each = local.configure_storage_account_resources.settings
  source   = "../../modules/storage_account"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

#module to deploy the diagnostic settings
module "diag_settings_prod" {
  for_each = local.configure_diag_settings_resources.settings
  source   = "../../modules/diagnostic_settings"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}

module "diag_settings_dmz" {
  for_each = local.configure_diag_settings_dmz_resources.settings
  source   = "../../modules/diagnostic_settings"
  providers = {
    azurerm = azurerm.dmz
  }
  settings = each.value
}

#module to deploy application insights
module "application_insights_prod" {
  for_each  = local.configure_ai_resources.settings
  source    = "../../modules/appinsights"
  providers = { azurerm.prod = azurerm.prod }
  settings  = each.value
}

#module to deploy route table
module "route_table_prod" {
  for_each = local.configure_udr_prod.settings
  source   = "../../modules/route_table"
  providers = {
    azurerm = azurerm.prod
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

module "resource_lock" {
  for_each      = local.configure_resource_lock.settings
  source        = "../../modules/resource_lock"
  providers     = { azurerm = azurerm.dmz }
  name          = each.value.name
  resourceScope = each.value.resourceScope
}

module "data_collection_rule" {
  for_each = local.configure_data_collection_rule_resources.settings
  source   = "../../modules/data_collection_rule"
  providers = {
    azurerm = azurerm.prod
  }
  settings = each.value
}
