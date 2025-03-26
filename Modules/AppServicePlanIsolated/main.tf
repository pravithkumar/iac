resource "azurerm_app_service_plan" "asp" {
  name                = var.app_service_plan_name
  location            = data.azurerm_virtual_network.existing.location
  resource_group_name = var.existing_vnet_resource_group
  kind                = "App"
  reserved            = true
  sku {
    tier = var.app_service_plan_sku_tier
    size = var.app_service_plan_sku_size
  }
  app_service_environment_id = azurerm_app_service_environment_v3.asp.id
}