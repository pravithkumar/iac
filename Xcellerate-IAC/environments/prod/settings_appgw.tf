locals {
  configure_appgw_resources = {

    settings = {

      "agw-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                = "agw-${var.app_name}-${var.environment}-${var.location}-001"
        location            = var.location
        resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        tags                = var.tags
        enable_http2        = false
        #zones               = []
        #firewall_policy_id                = "/subscriptions/63e172c2-18dc-47e9-a608-e6459cda78a3/resourceGroups/rg-waf-conn-prd-bay-aen-001/providers/Microsoft.Network/applicationGatewayWebApplicationFirewallPolicies/waf-conn-prd-bay-aen-001"
        force_firewall_policy_association = true
        identity = {
          type         = "UserAssigned"
          identity_ids = [module.managed_identity.id]
        }
        sku = {
          name = "Standard_v2"
          tier = "Standard_v2"
        }

        gateway_ip_configuration = [{
          name      = "agw_${var.app_name}_${var.environment}_${var.location}_001"
          subnet_id = data.azurerm_subnet.snet_agw_xl_prod_001.id
        }]

        frontend_ip_configuration = [
          {
            name                          = "agw-${var.app_name}-frontend-private-ip"
            private_ip_address_allocation = "Static"
            private_ip_address            = "10.48.94.101"
            subnet_id                     = data.azurerm_subnet.snet_agw_xl_prod_001.id
            ## added configuration_name
            #private_link_configuration_name = "link-appgw-${var.app_name}-${var.environment}-${var.location}-001"
          },
          {
            name                          = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
            private_ip_address_allocation = "Dynamic"
            public_ip_address_id          = module.public_ip.pip-agw-xl-prod-eastus-001.id
          }
        ]
        ## added the below block 
        # private_link_configuration = [{
        #   name = "link-appgw-${var.app_name}-${var.environment}-${var.location}-001"
        #   ip_configuration = [
        #     {
        #       name                          = "privateLinkIpConfig1"
        #       subnet_id                     = data.azurerm_subnet.dmz-snet-xl-prod-pe-001.id
        #       private_ip_address_allocation = "Dynamic"
        #       primary                       = false
        #       private_ip_address            = "Automatic"
        #     }
        #   ]
        #   }
        # ]

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
            fqdns = ["nextgen-xcellerate-prod01-eastus-api.cds.fortrea.com"]
          }
          //   {
          //     name         = "be-agw-prd-bay-aen-001"
          //     ip_addresses = ["10.254.20.4"]
          //   }
        ]

        backend_http_settings = [
          {
            #affinity_cookie_name                = "ApplicationGatewayAffinity"
            cookie_based_affinity = "Disabled"
            # connection_draining = {
            #   enabled = false
            # }
            name                                = "backend-https-settings"
            pick_host_name_from_backend_address = true
            probe_name                          = "hp-backend-https"
            port                                = 443
            protocol                            = "Https"
            request_timeout                     = 20
            trusted_root_certificate_names      = []

          }
          //   {
          //     affinity_cookie_name                = "ApplicationGatewayAffinity"
          //     cookie_based_affinity               = "Disabled"
          //     name                                = "bs-agw-prd-bay-aen-002"
          //     pick_host_name_from_backend_address = false
          //     port                                = 8080
          //     protocol                            = "Http"
          //     request_timeout                     = 20
          //     trusted_root_certificate_names      = []

          //   }

        ]

        http_listener = [
          {

            frontend_ip_configuration_name = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
            frontend_port_name             = "default_frontend_port"
            host_names                     = []
            name                           = "appgw-https-listener"
            protocol                       = "Http"
            require_sni                    = false
          },

          //   {

          //     frontend_ip_configuration_name = "pip-waf-conn-prd-bay-aen-001"
          //     frontend_port_name             = "port_443"
          //     host_names                     = []
          //     name                           = "fl-agw-prd-bay-aen-002"
          //     protocol                       = "Http"
          //     require_sni                    = false
          //     ssl_certificate_name           = "bay-servicedesk-prod-wc"
          //   }
        ]

        request_routing_rule = [
          {
            backend_address_pool_name  = "backend-pool"
            backend_http_settings_name = "backend-https-settings"
            http_listener_name         = "appgw-https-listener"
            name                       = "appgw-routing-rule-001"
            priority                   = 210
            // rewrite_rule_set_name      = "Xforwardingrewrite"
            rule_type = "Basic"
          }
        ]

        // rewrite_rule_set = [
        //   {
        //     name = "Xforwardingrewrite"

        //     rewrite_rule = [{
        //       name          = "Xforwarding_paloalto"
        //       rule_sequence = 100

        //       request_header_configuration = [{
        //         header_name  = "X-Forwarded-For"
        //         header_value = "{http_req_X-Forwarded-For}"
        //       }]
        //     }]

        //   }
        // ]

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
          //   {

          //     interval                                  = 30
          //     minimum_servers                           = 0
          //     name                                      = "hp-palo-alto-firewall"
          //     path                                      = "/"
          //     pick_host_name_from_backend_http_settings = true
          //     protocol                                  = "Http"
          //     timeout                                   = 30
          //     unhealthy_threshold                       = 3

          //     match = {
          //       status_code = ["200-399"]
          //     }

          // }
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
