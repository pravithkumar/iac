provider "azurerm" {
  features {}  
}

module "app_service_environment" {
  source                          = "../Modules/AppServiceEnvironment"
  ase_name                        = var.ase_name
  resource_group_name             = var.resource_group_name
  subnet_id                       = var.subnet_id
  internal_load_balancing_mode    = var.internal_load_balancing_mode
  disable_tls1_0                  = var.disable_tls1_0
  internal_encryption             = var.internal_encryption
  frontend_ssl_cipher_suite_order = var.frontend_ssl_cipher_suite_order
  tags                            = var.tags
}

module "app_service_resources" {
  source                          = "../Modules/AzureLogicApp"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  ase_name                        = var.ase_name
  ase_resource_group_name         = var.ase_resource_group_name
  storage_account_name            = var.storage_account_name
  storage_resource_group_name     = var.storage_resource_group_name
  app_service_plan_name           = var.app_service_plan_name
  logic_app_name                  = var.logic_app_name
}