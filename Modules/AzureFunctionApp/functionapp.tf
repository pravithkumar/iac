# Modules/AzureFunctionApp/functionapp.tf

# Data sources for existing resources
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_storage_account" "sa" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_app_service_plan" "asp" {
  id = var.app_service_plan_id
}

data "azurerm_application_insights" "ai" {
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group_name
}

resource "azurerm_function_app" "fa" {
  name                       = var.function_app_name
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  app_service_plan_id        = data.azurerm_app_service_plan.asp.id
  storage_account_name       = data.azurerm_storage_account.sa.name
  storage_account_access_key = data.azurerm_storage_account.sa.primary_access_key
  https_only = var.https_only
  always_on = var.always_on
  tags = var.tags
}

resource "azurerm_private_endpoint" "pe" {
  name                = "${var.function_app_name}-pe"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.function_app_name}-psc"
    private_connection_resource_id = azurerm_function_app.fa.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }
}