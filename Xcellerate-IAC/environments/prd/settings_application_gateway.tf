locals {
  configure_appgw_resources = {

    settings = {

      "agw-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                              = "agw-${var.app_name}-${var.environment}-${var.location}-001"
        location                          = var.location
        resource_group_name               = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        tags                              = var.tags
        enable_http2                      = false
        force_firewall_policy_association = true
        identity = {
          type         = "UserAssigned"
          identity_ids = [module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].id]
        }
        sku = {
          name = "Standard_v2"
          tier = "Standard_v2"
        }

        gateway_ip_configuration = [{
          name      = "agw_${var.app_name}_${var.environment}_${var.location}_001"
          subnet_id = data.azurerm_subnet.snet_agw_dmz.id
        }]

        frontend_ip_configuration = [
          {
            name                          = "agw-${var.app_name}-frontend-private-ip"
            private_ip_address_allocation = "Static"
            private_ip_address            = "10.48.94.116"
            subnet_id                     = data.azurerm_subnet.snet_agw_dmz.id
          },
          {
            name                          = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
            private_ip_address_allocation = "Dynamic"
            public_ip_address_id          = module.public_ip["pip-agw-${var.app_name}-${var.environment}-${var.location}-001"].id
          }
        ]

        frontend_port = [
          {
            name = "port_443"
            port = 443
          },
          {
            name = "default_frontend_port"
            port = 80
          },
          {
            name = "port_8090"
            port = 8090
          },
          {
            name = "port_34"
            port = 32
          }
        ]

        backend_address_pool = [

          {
            name  = "backend-pool"
            fqdns = var.backend_address_fqdns
          }
        ]

        backend_http_settings = [
          {
            cookie_based_affinity               = "Disabled"
            name                                = "backend-https-settings"
            pick_host_name_from_backend_address = true
            probe_name                          = "hp-backend-https"
            port                                = 443
            protocol                            = "Https"
            request_timeout                     = 20
            trusted_root_certificate_names      = []

          }
        ]

        http_listener = [
          {
            frontend_ip_configuration_name = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
            frontend_port_name             = "default_frontend_port"
            host_names                     = []
            name                           = "appgw-https-listener"
            protocol                       = "Http"
            require_sni                    = false
          }
        ]

        request_routing_rule = [
          {
            backend_address_pool_name  = "backend-pool"
            backend_http_settings_name = "backend-https-settings"
            http_listener_name         = "appgw-https-listener"
            name                       = "appgw-routing-rule-001"
            priority                   = 210
            rule_type                  = "Basic"
          }
        ]

        probe = [{
          interval                                  = 30
          minimum_servers                           = 0
          name                                      = "hp-backend-https"
          path                                      = "/version"
          pick_host_name_from_backend_http_settings = true
          protocol                                  = "Https"
          timeout                                   = 30
          unhealthy_threshold                       = 3

          match = {
            status_code = ["200-399"]
          }

          }
        ]

        ssl_policy = {
          policy_type          = "Custom"
          min_protocol_version = "TLSv1_2"
          cipher_suites = [
            "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
            "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
            "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
            "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
            "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
            "TLS_RSA_WITH_AES_256_GCM_SHA384",
            "TLS_RSA_WITH_AES_256_CBC_SHA256",
            "TLS_RSA_WITH_AES_256_CBC_SHA",
            "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
          ]
        }

        autoscale_configuration = {
          min_capacity = 1
          max_capacity = 2
        }
      }
    }
  }
}
