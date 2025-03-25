resource "azurerm_logic_app_standard" "logic_app" {
  name                = var.logic_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  storage_account_name = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  site_config {
    app_settings = {
      "WORKFLOWS_SUBSCRIPTION_ID" = var.subscription_id
      "WORKFLOWS_RESOURCE_GROUP_NAME" = var.resource_group_name
      "WORKFLOWS_STORAGE_ACCOUNT_NAME" = var.storage_account_name
    }
  }

  tags = var.tags
}