resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name # Use the same variable
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.aspsku_name
  worker_count        = var.worker_count
  tags                = var.tags
}