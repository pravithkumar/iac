resource "azurerm_api_management" "this" {
  name                = var.settings.name
  location            = var.settings.location
  resource_group_name = var.settings.resource_group_name
  publisher_name      = var.settings.publisher_name
  publisher_email     = var.settings.publisher_email
  sku_name            = var.settings.sku_name

  notification_sender_email     = var.settings.notification_sender_email
  public_network_access_enabled = var.settings.public_network_access_enabled
  virtual_network_type          = var.settings.virtual_network_type
  public_ip_address_id          = var.settings.public_ip_address_id

  dynamic "additional_location" {
    for_each = var.settings.additional_location != null ? var.settings.additional_location : []
    content {
      location             = additional_location.value.location
      capacity             = additional_location.value.capacity
      zones                = additional_location.value.zones
      public_ip_address_id = additional_location.value.public_ip_address_id
      gateway_disabled     = additional_location.value.gateway_disabled

      dynamic "virtual_network_configuration" {
        for_each = additional_location.value.virtual_network_configuration != null ? additional_location.value.virtual_network_configuration : []
        content {
          subnet_id = virtual_network_configuration.value.subnet_id
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = var.settings.certificate != null ? var.settings.certificate : []
    content {
      encoded_certificate  = certificate.value.encoded_certificate
      store_name           = certificate.value.store_name
      certificate_password = certificate.value.certificate_password
    }
  }

  client_certificate_enabled = var.settings.client_certificate_enabled

  dynamic "delegation" {
    for_each = var.settings.delegation != null ? [var.settings.delegation] : []
    content {
      subscriptions_enabled     = delegation.value.subscriptions_enabled
      user_registration_enabled = delegation.value.user_registration_enabled
      url                       = delegation.value.url
      validation_key            = delegation.value.validation_key
    }
  }

  gateway_disabled = var.settings.gateway_disabled
  min_api_version  = var.settings.min_api_version
  zones            = var.settings.zones

  dynamic "identity" {
    for_each = var.settings.identity != null ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "hostname_configuration" {
    for_each = var.settings.hostname_configuration != null ? [var.settings.hostname_configuration] : []
    content {
      dynamic "management" {
        for_each = hostname_configuration.value.management != null ? hostname_configuration.value.management : []
        content {
          host_name                    = management.value.host_name
          key_vault_id                 = management.value.key_vault_id
          negotiate_client_certificate = management.value.negotiate_client_certificate
        }
      }

      dynamic "portal" {
        for_each = hostname_configuration.value.portal != null ? hostname_configuration.value.portal : []
        content {
          host_name                    = portal.value.host_name
          key_vault_id                 = portal.value.key_vault_id
          negotiate_client_certificate = portal.value.negotiate_client_certificate
        }
      }

      dynamic "proxy" {
        for_each = hostname_configuration.value.proxy != null ? hostname_configuration.value.proxy : []
        content {
          host_name                    = proxy.value.host_name
          key_vault_id                 = proxy.value.key_vault_id
          negotiate_client_certificate = proxy.value.negotiate_client_certificate
        }
      }

      dynamic "scm" {
        for_each = hostname_configuration.value.scm != null ? hostname_configuration.value.scm : []
        content {
          host_name                    = scm.value.host_name
          key_vault_id                 = scm.value.key_vault_id
          negotiate_client_certificate = scm.value.negotiate_client_certificate
        }
      }
    }
  }

  dynamic "protocols" {
    for_each = var.settings.protocols != null ? [var.settings.protocols] : []
    content {
      enable_http2 = protocols.value.enable_http2
    }
  }

  dynamic "security" {
    for_each = var.settings.security != null ? [var.settings.security] : []
    content {
      enable_backend_ssl30                                = security.value.enable_backend_ssl30
      enable_backend_tls10                                = security.value.enable_backend_tls10
      enable_backend_tls11                                = security.value.enable_backend_tls11
      enable_frontend_ssl30                               = security.value.enable_frontend_ssl30
      enable_frontend_tls10                               = security.value.enable_frontend_tls10
      enable_frontend_tls11                               = security.value.enable_frontend_tls11
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      triple_des_ciphers_enabled                          = security.value.triple_des_ciphers_enabled
    }
  }

  dynamic "sign_in" {
    for_each = var.settings.sign_in != null ? [var.settings.sign_in] : []
    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.settings.sign_up != null ? [var.settings.sign_up] : []
    content {
      enabled = sign_up.value.enabled
      terms_of_service {
        consent_required = sign_up.value.terms_of_service.consent_required
        enabled          = sign_up.value.terms_of_service.enabled
        text             = sign_up.value.terms_of_service.text
      }
    }
  }

  dynamic "tenant_access" {
    for_each = var.settings.tenant_access != null ? [var.settings.tenant_access] : []
    content {
      enabled = tenant_access.value.enabled
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.settings.virtual_network_configuration != null ? [var.settings.virtual_network_configuration] : []
    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }

  tags = var.settings.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_api_management_certificate" "this" {
  for_each                     = try({ for n in var.settings.api_management_certificate : n.name => n }, {})
  name                         = each.key
  api_management_name          = azurerm_api_management.this.name
  resource_group_name          = var.settings.resource_group_name
  data                         = each.value.data
  password                     = each.value.password
  key_vault_secret_id          = each.value.key_vault_secret_id
  key_vault_identity_client_id = each.value.key_vault_identity_client_id
}
