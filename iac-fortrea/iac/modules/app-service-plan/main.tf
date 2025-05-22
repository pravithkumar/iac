data "azurerm_app_service_environment_v3" "ase" {
  name                = var.ase_name
  resource_group_name = var.ase_resource_group_name
}

resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name # Use the same variable
  location            = var.location 
  os_type             = var.os_type
  sku_name            = var.aspsku_name
  worker_count        = var.worker_count
  app_service_environment_id = data.azurerm_app_service_environment_v3.ase.id
  tags                = var.tags
}