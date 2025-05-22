variable "settings" {
  description = "Configuration settings for the API Management service"
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    publisher_name      = string
    publisher_email     = string
    sku_name            = string

    additional_location = optional(list(object({
      location             = string
      capacity             = optional(number)
      zones                = optional(list(string))
      public_ip_address_id = optional(string)
      gateway_disabled     = optional(bool)
      virtual_network_configuration = optional(list(object({
        subnet_id = string
      })))
    })))

    certificate = optional(list(object({
      encoded_certificate  = string
      store_name           = string
      certificate_password = optional(string)
    })))

    client_certificate_enabled    = optional(bool)
    gateway_disabled              = optional(bool)
    min_api_version               = optional(string)
    zones                         = optional(list(string))
    notification_sender_email     = optional(string)
    public_network_access_enabled = optional(bool)
    virtual_network_type          = optional(string)
    public_ip_address_id          = optional(string)

    delegation = optional(object({
      subscriptions_enabled     = optional(bool)
      user_registration_enabled = optional(bool)
      url                       = optional(string)
      validation_key            = optional(string)
    }))

    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
    }))

    virtual_network_configuration = optional(object({
      subnet_id = string
    }))

    protocols = optional(object({
      enable_http2 = optional(bool)
    }))

    security = optional(object({
      enable_backend_ssl30                                = optional(bool)
      enable_backend_tls10                                = optional(bool)
      enable_backend_tls11                                = optional(bool)
      enable_frontend_ssl30                               = optional(bool)
      enable_frontend_tls10                               = optional(bool)
      enable_frontend_tls11                               = optional(bool)
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool)
      triple_des_ciphers_enabled                          = optional(bool)
    }))

    sign_in = optional(object({
      enabled = bool
    }))

    sign_up = optional(object({
      enabled = bool
      terms_of_service = object({
        consent_required = bool
        enabled          = bool
        text             = optional(string)
      })
    }))

    tenant_access = optional(object({
      enabled = bool
    }))

    hostname_configuration = optional(object({
      management = optional(list(object({
        host_name                       = string
        key_vault_id                    = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool)
        ssl_keyvault_identity_client_id = optional(string)
      })))

      portal = optional(list(object({
        host_name                       = string
        key_vault_id                    = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool)
        ssl_keyvault_identity_client_id = optional(string)
      })))

      developer_portal = optional(list(object({
        host_name                       = string
        key_vault_id                    = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool)
        ssl_keyvault_identity_client_id = optional(string)
      })))

      proxy = optional(list(object({
        host_name                       = string
        key_vault_id                    = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        default_ssl_binding             = optional(bool)
        negotiate_client_certificate    = optional(bool)
        ssl_keyvault_identity_client_id = optional(string)
      })))

      scm = optional(list(object({
        host_name                       = string
        key_vault_id                    = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool)
        ssl_keyvault_identity_client_id = optional(string)
      })))
    }))

    tags = optional(map(string))


    api_management_certificate = optional(list(object({
      name                         = string
      key_vault_secret_id          = string
      data                         = optional(string)
      password                     = optional(string)
      key_vault_identity_client_id = optional(string)
    })))
  })
}
