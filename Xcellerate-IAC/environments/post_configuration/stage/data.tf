data "azurerm_key_vault" "kv_applz" {
  provider            = azurerm.applz
  name                = "kv-${var.app_name}-${var.environment}-${var.location}-001"
  resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
}

data "azurerm_key_vault" "kv_dmz" {
  provider            = azurerm.dmz
  name                = "kv-${var.app_name}-${var.environment}-dmz-${var.location}-001"
  resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
}

data "azurerm_client_config" "current" {
}

data "azurerm_user_assigned_identity" "user_mi" {
  provider             = azurerm.applz
  name                = "mi-${var.app_name}-${var.environment}-${var.location}-001"
  resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
}

data "azurerm_application_gateway" "appgw" {
  provider = azurerm.dmz
  name                = "agw-${var.app_name}-${var.environment}-${var.location}-001"
  resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
}

data "azurerm_api_management" "apim" {
  provider            = azurerm.applz
  name                = "apim-${var.app_name}-${var.environment}-${var.location}-001"
  resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
}

data "azurerm_key_vault_certificate" "agcertificate" {
  provider = azurerm.dmz
  name         = "cert-int-${var.app_name}-${var.environment}-${var.location}-agw"
  key_vault_id = data.azurerm_key_vault.kv_dmz.id
}

data "azurerm_key_vault_certificate" "rbqmcertificate" {
  provider = azurerm.dmz
  name         = "cert-ext-${var.app_name}-${var.environment}-${var.location}-rbqm-stg"
  key_vault_id = data.azurerm_key_vault.kv_dmz.id
}

data "azurerm_key_vault_certificate" "apicertificate" {
  provider            = azurerm.applz
  name         = "cert-int-${var.app_name}-${var.environment}-${var.location}-api"
  key_vault_id = data.azurerm_key_vault.kv_applz.id
}

data "azurerm_key_vault_certificate" "akscertificate" {
  provider            = azurerm.applz
  name         = "cert-int-${var.app_name}-${var.environment}-${var.location}-aks"
  key_vault_id = data.azurerm_key_vault.kv_applz.id
}

