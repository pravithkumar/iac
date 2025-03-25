resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  workflow {
    definition = var.workflow_definition
  }
  tags = var.tags
}