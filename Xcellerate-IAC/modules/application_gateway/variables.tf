variable "settings" {
  description = "Application gateway settings"
  type = object({
    name                              = string
    resource_group_name               = string
    location                          = string
    tags                              = map(string)
    fips_enabled                      = optional(bool)
    zones                             = optional(list(string))
    enable_http2                      = optional(bool)
    force_firewall_policy_association = optional(bool)
    firewall_policy_id                = optional(string)

    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))

    sku = optional(object({
      name     = string
      tier     = string
      capacity = optional(number)
    }))

    gateway_ip_configuration = optional(list(object({
      name      = string
      subnet_id = string
    })))

    frontend_port = optional(list(object({
      name = string
      port = number
    })))

    frontend_ip_configuration = optional(list(object({
      name                            = string
      public_ip_address_id            = optional(string)
      subnet_id                       = optional(string)
      private_ip_address              = optional(string)
      private_ip_address_allocation   = optional(string)
      private_link_configuration_name = optional(string)
    })))

    backend_address_pool = optional(list(object({
      name         = string
      fqdns        = optional(list(string))
      ip_addresses = optional(list(string))
    })))

    backend_http_settings = optional(list(object({
      name                                = string
      cookie_based_affinity               = optional(string)
      affinity_cookie_name                = optional(string)
      path                                = optional(string)
      port                                = number
      protocol                            = string
      request_timeout                     = optional(number)
      host_name                           = optional(number)
      pick_host_name_from_backend_address = optional(bool)
      probe_name                          = optional(string)
      trusted_root_certificate_names      = optional(list(string))

      connection_draining = optional(object({
        enabled           = optional(bool)
        drain_timeout_sec = optional(number)
      }))


    })))

    http_listener = optional(list(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      protocol                       = string
      host_name                      = optional(string)
      host_names                     = optional(list(string))
      require_sni                    = optional(bool)
      ssl_certificate_name           = optional(string)
      firewall_policy_id             = optional(string)
      ssl_profile_name               = optional(string)
    })))

    request_routing_rule = optional(list(object({
      name                       = string
      priority                   = number
      rule_type                  = string
      http_listener_name         = string
      backend_address_pool_name  = string
      backend_http_settings_name = string
    })))

    private_link_configuration = optional(list(object({
      name = string
      ip_configuration = optional(list(object({
        name                          = string
        subnet_id                     = string
        private_ip_address_allocation = string
        primary                       = bool
        private_ip_address            = string
      })))
    })))

    trusted_client_certificate = optional(list(object({
      name = string
      data = string
    })))

    ssl_profile = optional(list(object({
      name                                 = string
      trusted_client_certificate_names     = list(string)
      verify_client_cert_issuer_dn         = bool
      verify_client_certificate_revocation = bool
      ssl_policy = optional(object({
        disabled_protocols   = list(string)
        policy_type          = string
        policy_name          = string
        cipher_suites        = list(string)
        min_protocol_version = string
      }))
    })))

    authentication_certificate = optional(list(object({
      name = string
      data = string
    })))

    trusted_root_certificate = optional(list(object({
      name                = string
      data                = string
      key_vault_secret_id = string
    })))

    ssl_certificate = optional(list(object({
      name                = string
      data                = string
      password            = string
      key_vault_secret_id = string
    })))

    ssl_policy = optional(object({
      disabled_protocols   = optional(list(string))
      policy_type          = string
      policy_name          = optional(string)
      cipher_suites        = list(string)
      min_protocol_version = string
    }))

    probe = optional(list(object({
      name                                      = string
      host                                      = optional(string)
      interval                                  = number
      protocol                                  = string
      path                                      = string
      timeout                                   = number
      unhealthy_threshold                       = number
      port                                      = optional(number)
      pick_host_name_from_backend_http_settings = optional(bool)
      minimum_servers                           = optional(number)
      match = optional(object({
        body        = optional(string)
        status_code = list(string)
      }))
    })))

    url_path_map = optional(list(object({
      name                                = string
      default_backend_address_pool_name   = string
      default_backend_http_settings_name  = string
      default_redirect_configuration_name = string
      default_rewrite_rule_set_name       = string
      path_rule = optional(list(object({
        id                        = string
        backend_address_pool_id   = string
        backend_http_settings_id  = string
        redirect_configuration_id = string
        rewrite_rule_set_id       = string
        paths                     = list(string)
        name                      = string
      })))
    })))

    global = optional(object({
      request_buffering_enabled  = bool
      response_buffering_enabled = bool
    }))

    waf_configuration = optional(object({
      enabled                  = bool
      firewall_mode            = string
      rule_set_type            = string
      rule_set_version         = string
      file_upload_limit_mb     = number
      request_body_check       = bool
      max_request_body_size_kb = number
      disabled_rule_group = optional(list(object({
        rules           = list(number)
        rule_group_name = string
      })))
      exclusion = optional(list(object({
        match_variable          = string
        selector_match_operator = string
        selector                = string
      })))
    }))

    custom_error_configuration = optional(list(object({
      status_code           = number
      custom_error_page_url = string
    })))

    redirect_configuration = optional(list(object({
      name                 = string
      redirect_type        = string
      target_listener_name = string
      target_url           = string
      include_path         = bool
      include_query_string = bool
    })))

    rewrite_rule_set = optional(list(object({
      name = string

      rewrite_rule = optional(list(object({
        name          = string
        rule_sequence = number

        condition = optional(list(object({
          variable    = string
          pattern     = string
          ignore_case = optional(bool)
          negate      = optional(bool)
        })))

        request_header_configuration = optional(list(object({
          header_name  = string
          header_value = string
        })))

        response_header_configuration = optional(list(object({
          header_name  = string
          header_value = string
        })))

      })))
    })))

    autoscale_configuration = optional(object({
      min_capacity = number
      max_capacity = number
    }))
  })
}
