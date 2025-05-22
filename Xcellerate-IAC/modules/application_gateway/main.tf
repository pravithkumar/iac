resource "azurerm_application_gateway" "this" {
  provider                          = azurerm.dmz
  name                              = var.settings.name
  resource_group_name               = var.settings.resource_group_name
  location                          = var.settings.location
  fips_enabled                      = var.settings.fips_enabled
  zones                             = var.settings.zones
  enable_http2                      = var.settings.enable_http2
  force_firewall_policy_association = var.settings.force_firewall_policy_association
  firewall_policy_id                = var.settings.firewall_policy_id
  tags                              = var.settings.tags

  lifecycle {
    ignore_changes = [http_listener, ssl_certificate, tags]
  }


  dynamic "identity" {
    for_each = var.settings.identity != null ? [var.settings.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "sku" {
    for_each = var.settings.sku != null ? [var.settings.sku] : []
    content {
      name     = sku.value.name
      tier     = sku.value.tier
      capacity = sku.value.capacity
    }
  }

  dynamic "gateway_ip_configuration" {
    for_each = var.settings.gateway_ip_configuration != null ? var.settings.gateway_ip_configuration : []
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = gateway_ip_configuration.value.subnet_id
    }
  }


  dynamic "frontend_port" {
    for_each = var.settings.frontend_port != null ? var.settings.frontend_port : []
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.settings.frontend_ip_configuration != null ? var.settings.frontend_ip_configuration : []
    content {
      name                            = frontend_ip_configuration.value.name
      public_ip_address_id            = frontend_ip_configuration.value.public_ip_address_id
      subnet_id                       = frontend_ip_configuration.value.subnet_id
      private_ip_address              = frontend_ip_configuration.value.private_ip_address
      private_ip_address_allocation   = frontend_ip_configuration.value.private_ip_address_allocation
      private_link_configuration_name = frontend_ip_configuration.value.private_link_configuration_name
    }
  }


  dynamic "backend_address_pool" {
    for_each = var.settings.backend_address_pool != null ? var.settings.backend_address_pool : []
    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.settings.backend_http_settings != null ? var.settings.backend_http_settings : []
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = backend_http_settings.value.cookie_based_affinity
      affinity_cookie_name                = backend_http_settings.value.affinity_cookie_name
      path                                = backend_http_settings.value.path
      port                                = backend_http_settings.value.port
      protocol                            = backend_http_settings.value.protocol
      request_timeout                     = backend_http_settings.value.request_timeout
      host_name                           = backend_http_settings.value.host_name
      pick_host_name_from_backend_address = backend_http_settings.value.pick_host_name_from_backend_address
      probe_name                          = backend_http_settings.value.probe_name
      trusted_root_certificate_names      = backend_http_settings.value.trusted_root_certificate_names

      dynamic "connection_draining" {
        for_each = backend_http_settings.value.connection_draining != null ? [backend_http_settings.value.connection_draining] : []
        content {
          enabled           = connection_draining.value.enabled
          drain_timeout_sec = connection_draining.value.drain_timeout_sec
        }

      }
    }
  }

  dynamic "http_listener" {
    for_each = var.settings.http_listener != null ? var.settings.http_listener : []
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = http_listener.value.host_name
      host_names                     = http_listener.value.host_names
      require_sni                    = http_listener.value.require_sni
      ssl_certificate_name           = http_listener.value.ssl_certificate_name
      firewall_policy_id             = http_listener.value.firewall_policy_id
      ssl_profile_name               = http_listener.value.ssl_profile_name

    }
  }

  dynamic "request_routing_rule" {
    for_each = var.settings.request_routing_rule != null ? var.settings.request_routing_rule : []
    content {
      name                       = request_routing_rule.value.name
      priority                   = request_routing_rule.value.priority
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_settings_name
    }
  }

  dynamic "private_link_configuration" {
    for_each = var.settings.private_link_configuration != null ? var.settings.private_link_configuration : []
    content {
      name = private_link_configuration.value.name
      dynamic "ip_configuration" {
        for_each = private_link_configuration.value.ip_configuration != null ? private_link_configuration.value.ip_configuration : []
        content {
          name                          = ip_configuration.value.name
          subnet_id                     = ip_configuration.value.subnet_id
          private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
          primary                       = ip_configuration.value.primary
          private_ip_address            = ip_configuration.value.private_ip_address

        }
      }

    }
  }

  dynamic "trusted_client_certificate" {
    for_each = var.settings.trusted_client_certificate != null ? var.settings.trusted_client_certificate : []
    content {
      name = trusted_client_certificate.value.name
      data = trusted_client_certificate.value.data
    }
  }


  dynamic "ssl_profile" {
    for_each = var.settings.ssl_profile != null ? var.settings.ssl_profile : []
    content {
      name                                 = ssl_profile.value.name
      trusted_client_certificate_names     = ssl_profile.value.trusted_client_certificate_names
      verify_client_cert_issuer_dn         = ssl_profile.value.verify_client_cert_issuer_dn
      verify_client_certificate_revocation = ssl_profile.value.verify_client_certificate_revocation

      dynamic "ssl_policy" {
        for_each = ssl_profile.value.ssl_policy != null ? [ssl_profile.value.ssl_policy] : []
        content {
          disabled_protocols   = ssl_policy.value.disabled_protocols
          policy_type          = ssl_policy.value.policy_type
          policy_name          = ssl_policy.value.policy_name
          cipher_suites        = ssl_policy.value.cipher_suites
          min_protocol_version = ssl_policy.value.min_protocol_version
        }
      }
    }
  }

  dynamic "authentication_certificate" {
    for_each = var.settings.authentication_certificate != null ? var.settings.authentication_certificate : []
    content {
      name = authentication_certificate.value.name
      data = authentication_certificate.value.data
    }
  }

  dynamic "trusted_root_certificate" {
    for_each = var.settings.trusted_root_certificate != null ? var.settings.trusted_root_certificate : []
    content {
      name                = trusted_root_certificate.value.name
      data                = trusted_root_certificate.value.data
      key_vault_secret_id = trusted_root_certificate.value.key_vault_secret_id
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.settings.ssl_certificate != null ? var.settings.ssl_certificate : []
    content {
      name                = ssl_certificate.value.name
      data                = ssl_certificate.value.data
      password            = ssl_certificate.value.password
      key_vault_secret_id = ssl_certificate.value.key_vault_secret_id
    }
  }

  dynamic "ssl_policy" {
    for_each = var.settings.ssl_policy != null ? [var.settings.ssl_policy] : []
    content {
      disabled_protocols   = ssl_policy.value.disabled_protocols
      policy_type          = ssl_policy.value.policy_type
      policy_name          = ssl_policy.value.policy_name
      cipher_suites        = ssl_policy.value.cipher_suites
      min_protocol_version = ssl_policy.value.min_protocol_version
    }
  }

  dynamic "probe" {
    for_each = var.settings.probe != null ? var.settings.probe : []
    content {
      name                                      = probe.value.name
      host                                      = probe.value.host
      interval                                  = probe.value.interval
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      port                                      = probe.value.port
      pick_host_name_from_backend_http_settings = probe.value.pick_host_name_from_backend_http_settings
      minimum_servers                           = probe.value.minimum_servers

      dynamic "match" {
        for_each = probe.value.match != null ? [probe.value.match] : []
        content {
          body        = match.value.body
          status_code = match.value.status_code
        }
      }
    }
  }

  dynamic "url_path_map" {
    for_each = var.settings.url_path_map != null ? var.settings.url_path_map : []
    content {
      name                                = url_path_map.value.name
      default_backend_address_pool_name   = url_path_map.value.default_backend_address_pool_name
      default_backend_http_settings_name  = url_path_map.value.default_backend_http_settings_name
      default_redirect_configuration_name = url_path_map.value.default_redirect_configuration_name
      default_rewrite_rule_set_name       = url_path_map.value.default_rewrite_rule_set_name

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rule != null ? url_path_map.value.path_rule : []
        content {
          id                        = path_rule.value.id
          backend_address_pool_id   = path_rule.value.backend_address_pool_id
          backend_http_settings_id  = path_rule.value.backend_http_settings_id
          redirect_configuration_id = path_rule.value.redirect_configuration_id
          rewrite_rule_set_id       = path_rule.value.rewrite_rule_set_id
          paths                     = path_rule.value.paths
          name                      = path_rule.value.name
        }
      }
    }
  }


  dynamic "global" {
    for_each = var.settings.global != null ? [var.settings.global] : []
    content {
      request_buffering_enabled  = global.value.request_buffering_enabled
      response_buffering_enabled = global.value.response_buffering_enabled
    }
  }

  dynamic "waf_configuration" {
    for_each = var.settings.waf_configuration != null ? [var.settings.waf_configuration] : []
    content {
      enabled                  = waf_configuration.value.enabled
      firewall_mode            = waf_configuration.value.firewall_mode
      rule_set_type            = waf_configuration.value.rule_set_type
      rule_set_version         = waf_configuration.value.rule_set_version
      file_upload_limit_mb     = waf_configuration.value.file_upload_limit_mb
      request_body_check       = waf_configuration.value.request_body_check
      max_request_body_size_kb = waf_configuration.value.max_request_body_size_kb

      dynamic "disabled_rule_group" {
        for_each = waf_configuration.value.disabled_rule_group != null ? waf_configuration.value.disabled_rule_group : []
        content {
          rules           = disabled_rule_group.value.rules
          rule_group_name = disabled_rule_group.value.rule_group_name

        }
      }

      dynamic "exclusion" {
        for_each = waf_configuration.value.exclusion != null ? waf_configuration.value.exclusion : []
        content {
          match_variable          = exclusion.value.match_variable
          selector_match_operator = exclusion.value.selector_match_operator
          selector                = exclusion.value.selector
        }
      }
    }
  }


  dynamic "custom_error_configuration" {
    for_each = var.settings.custom_error_configuration != null ? var.settings.custom_error_configuration : []
    content {
      status_code           = custom_error_configuration.value.status_code
      custom_error_page_url = custom_error_configuration.value.custom_error_page_url
    }
  }


  dynamic "redirect_configuration" {
    for_each = var.settings.redirect_configuration != null ? var.settings.redirect_configuration : []
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = redirect_configuration.value.target_listener_name
      target_url           = redirect_configuration.value.target_url
      include_path         = redirect_configuration.value.include_path
      include_query_string = redirect_configuration.value.include_query_string
    }
  }
  dynamic "rewrite_rule_set" {
    for_each = var.settings.rewrite_rule_set != null ? var.settings.rewrite_rule_set : []
    content {
      name = rewrite_rule_set.value.name
      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rule != null ? rewrite_rule_set.value.rewrite_rule : []
        content {
          name          = rewrite_rule.value.name
          rule_sequence = rewrite_rule.value.rule_sequence
          dynamic "condition" {
            for_each = rewrite_rule.value.condition != null ? rewrite_rule.value.condition : []
            content {
              variable    = condition.value.variable
              pattern     = condition.value.pattern
              ignore_case = condition.value.ignore_case
              negate      = condition.value.negate
            }
          }

          dynamic "request_header_configuration" {
            for_each = rewrite_rule.value.request_header_configuration != null ? rewrite_rule.value.request_header_configuration : []
            content {
              header_name  = request_header_configuration.value.header_name
              header_value = request_header_configuration.value.header_value
            }
          }

          dynamic "response_header_configuration" {
            for_each = rewrite_rule.value.response_header_configuration != null ? rewrite_rule.value.response_header_configuration : []
            content {
              header_name  = response_header_configuration.value.header_name
              header_value = response_header_configuration.value.header_value
            }
          }

        }
      }

    }
  }


  dynamic "autoscale_configuration" {
    for_each = var.settings.autoscale_configuration != null ? [var.settings.autoscale_configuration] : []
    content {
      min_capacity = autoscale_configuration.value.min_capacity
      max_capacity = autoscale_configuration.value.max_capacity
    }
  }

}




locals {
  merged_settings = merge(
    {
      name                = "example-appgw"
      resource_group_name = "example-rg"
      location            = "eastus"
      tags                = {}
    },
    var.settings
  )
}