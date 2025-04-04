provider "azurerm" {
  features {}
}

module "infrastructure" {
  source    = "../modules/rg-vnet-dns"
  providers = { azurerm = azurerm.integ-nprod-001 }

  resource_groups       = var.resource_groups
  location              = var.location
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  subnets               = var.subnets
  private_dns_zones     = var.private_dns_zones
}

module "logworkspace" {
  source     = "..modules/log-analytics-workspace"
  law_name                = var.loganalytics.name
  location            = var.location
  resource_group_name = var.loganalytics.resource_group_name
  sku                 = var.loganalytics.sku
  retention_in_days   = var.loganalytics.retention_in_days
  identity            = var.loganalytics.identity
  tags                = var.tags
}

module "app_insight" {
  source = ".../modules/application-insights"
  appinsights_name    = var.appinsights.name
  location            = var.location
  resource_group_name = var.appinsights.resource_group_name
  law_workspace_id    = var.appinsights.law_workspace_id
  application_type    = var.appinsights.application_type
  retention_in_days   = var.appinsights.retention_in_days
  tags                = var.tags
}