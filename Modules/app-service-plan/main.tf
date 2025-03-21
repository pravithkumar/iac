data "azurerm_resource_group" "rg" {
  name = var.asp_resource_group_name
}

resource "azurerm_service_plan" "asp" {
  provider = azurerm.aiml-nprod-001
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = data.azurerm_resource_group.rg.location
  os_type             = var.os_type
  sku_name = var.aspsku_name
  worker_count = var.worker_count
  tags = var.tags
    
}