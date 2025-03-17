# modules/function_app_and_pe/main.tf

data "azurerm_storage_account" "storage" {
  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group_name
}

data "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  resource_group_name = var.app_insights_resource_group_name
}

resource "azurerm_function_app" "function_app" {
  name                       = var.function_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key
  app_insights_key           = data.azurerm_application_insights.app_insights.instrumentation_key
  https_only                 = var.https_only
  site_config {
    always_on = var.always_on
    ftps_state = "FtpsOnly"
    min_tls_version = "1.2"
    application_stack {
      dotnet_version    = var.runtime == "dotnet" ? var.runtime_version : null
      node_version      = var.runtime == "node" ? var.runtime_version : null
      python_version    = var.runtime == "python" ? var.runtime_version : null
      java_version      = var.runtime == "java" ? var.runtime_version : null
      powershell_version = var.runtime == "powershell" ? var.runtime_version : null
      custom_runtime_config = var.runtime == "custom" ? var.runtime_version : null
    }

    app_settings = {
      "FUNCTIONS_EXTENSION_VERSION"         = "~4"
      "FUNCTIONS_WORKER_RUNTIME"            = var.runtime
      "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = "DefaultEndpointsProtocol=https;AccountName=<span class="math-inline">\{data\.azurerm\_storage\_account\.storage\.name\};AccountKey\=</span>{data.azurerm_storage_account.storage.primary_access_key}"
      "WEBSITE_CONTENTSHARE"                = lower("<span class="math-inline">\{var\.function\_app\_name\}content"\)
"WEBSITE\_RUN\_FROM\_PACKAGE"            \= "1"
\}
\}
version \= "\~4"
tags \= var\.tags
\}
resource "azurerm\_private\_endpoint" "function\_app\_pe" \{
name                \= "</span>{var.function_app_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.function_app_name}-psc"
    private_connection_resource_id = azurerm_function_app.function_app.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags