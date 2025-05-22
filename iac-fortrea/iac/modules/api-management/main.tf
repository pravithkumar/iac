resource "azurerm_api_management" "api" {
  name                = var.api_management_name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = "${var.sku}_${var.sku_count}"
  tags                = var.tags

 
  timeouts {
    create = "120m"
    delete = "120m"
  }

  dynamic "identity" {
  for_each = var.identity_type != null ? [1] : []
  content {
    type       = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
  }
}

dynamic "security" {
    for_each = var.security_configuration
 
    content {
      backend_ssl30_enabled  = security.value.backend_ssl30_enabled
      backend_tls10_enabled  = security.value.backend_tls10_enabled
      backend_tls11_enabled  = security.value.backend_tls11_enabled
      frontend_ssl30_enabled = security.value.frontend_ssl30_enabled
      frontend_tls10_enabled = security.value.frontend_tls10_enabled
      frontend_tls11_enabled = security.value.frontend_tls11_enabled
 
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled    
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = security.value.tls_rsa_with_aes256_gcm_sha384_ciphers_enabled
 
      triple_des_ciphers_enabled = security.value.triple_des_ciphers_enabled
    }
  }
}

resource "azurerm_api_management_identity_provider_aad" "api-aad" {
  api_management_name = azurerm_api_management.api.name
  resource_group_name = var.resource_group_name 

  client_id     = var.client_id
  client_secret = var.client_secret
  client_library = "MSAL"  
  allowed_tenants = var.allowed_tenants  
}
resource "azurerm_api_management_logger" "logger" {
  name                = "appinsights_logger"
  api_management_name = azurerm_api_management.api.name
  resource_group_name = var.resource_group_name
  resource_id         = var.app_insights_id

  application_insights {
    instrumentation_key = var.app_insights_key
  }
}