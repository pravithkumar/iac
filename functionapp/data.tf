data "azurerm_log_analytics_workspace" "existing" {
  name                = "your-log-analytics-workspace-name"
  resource_group_name = "your-resource-group-name"
}

data "azurerm_application_insights" "ai" {
  provider            = azurerm.integ-mgmt-001
  name                = "appinsights-int-esu-001"
  resource_group_name = "rg-int-apps-esu-003"
}

data "azurerm_private_dns_zone" "function_app_dns" {
  provider            = azurerm.integ-mgmt-001
  name                = "privatelink.azurewebsites.net"
  resource_group_name = "rg-int-dns-esu-002"
}