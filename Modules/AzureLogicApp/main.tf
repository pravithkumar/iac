resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  location            = data.azurerm_virtual_network.existing_vnet.location
  resource_group_name = var.existing_vnet_resource_group
  app_service_plan_id = azurerm_app_service_plan.app_service_plan.id
}