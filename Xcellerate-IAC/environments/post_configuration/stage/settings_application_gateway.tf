// locals {
//   configure_appgw_resources = {

//     settings = {

//       "agw-${var.app_name}-${var.environment}-${var.location}-001" = {
//         name                              = data.azurerm_application_gateway.appgw.name
//         location                          = data.azurerm_application_gateway.appgw.location
//         resource_group_name               = data.azurerm_application_gateway.appgw.resource_group_name
//         tags                              = data.azurerm_application_gateway.appgw.tags
//         enable_http2                      = data.azurerm_application_gateway.appgw.enable_http2
//         force_firewall_policy_association = true
//         identity = {
//           type         = "UserAssigned"
//           identity_ids = [data.azurerm_user_assigned_identity.user_mi.id]
//         }
//         sku = {
//           name = "Standard_v2"
//           tier = "Standard_v2"
//         }

//         gateway_ip_configuration = [{
//           name      = "agw_${var.app_name}_${var.environment}_${var.location}_001"
//           subnet_id = data.azurerm_application_gateway.appgw.gateway_ip_configuration[0].subnet_id
//         }]

//         ssl_certificate = {
//             name = "rbqm-fortrea" # need to confirm
//         }
//         ssl_certificate = {
//             name = "Rbqmcert" # need to confirm
//             data = filebase64("path/to/file")  # need to update
//         }
       
//         frontend_ip_configuration = [
//           {
//             name                          = "agw-${var.app_name}-frontend-private-ip"
//             private_ip_address_allocation = "Static"
//             private_ip_address            = "10.48.94.116"
//             subnet_id                     = data.azurerm_application_gateway.appgw.frontend_ip_configuration[0].subnet_id
//           },
//           {
//             name                          = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
//             private_ip_address_allocation = "Dynamic"
//             public_ip_address_id          = data.azurerm_application_gateway.appgw.frontend_ip_configuration[1].public_ip_address_id
//           }
//         ]

//         frontend_port = [
//           {
//             name = "port_443"
//             port = 443
//           },
//           {
//             name = "default_frontend_port"
//             port = 80
//           },
//           {
//             name = "port_8090"
//             port = 8090
//           },
//           {
//             name = "port_34"
//             port = 32
//           }
//         ]

//         backend_address_pool = [

//           {
//             name  = "backend-pool"
//             fqdns = data.azurerm_application_gateway.appgw.backend_address_pool[0].fqdns
//           }
//         ]

//         backend_http_settings = [
//           {
//             cookie_based_affinity               = "Disabled"
//             name                                = "backend-https-settings"
//             pick_host_name_from_backend_address = true
//             probe_name                          = "hp-backend-https"
//             port                                = 443
//             protocol                            = "Https"
//             request_timeout                     = 20
//             trusted_root_certificate_names      = [aks-root-cert] # need to confirm

//           }
//         ]

//         # http_listener = [
//         #   {
//         #     frontend_ip_configuration_name = "agw-${var.app_name}-frontend-private-ip"
//         #     frontend_port_name             = "port_443"
//         #     host_names                     = ["rbqm.fortrea.com"]
//         #     name                           = "appgw-private-https-listener"
//         #     protocol                       = "Https"
//         #     require_sni                    = true
//         #     ssl_certificate_name          = "Rbqmcert"
//         #   }
//         # ]

//         #  http_listener = [
//         #   {
//         #     frontend_ip_configuration_name = "pip-agw-${var.app_name}-${var.environment}-${var.location}-001"
//         #     frontend_port_name             = "port_443"
//         #     host_names                     = ["rbqm.fortrea.com"]
//         #     name                           = "appgw-https-listener"
//         #     protocol                       = "Https"
//         #     require_sni                    = true
//         #     ssl_certificate_name          = "Rbqmcert"
//         #   }
//         # ]

//         # request_routing_rule = [
//         #   {
//         #     backend_address_pool_name  = "backend-pool"
//         #     backend_http_settings_name = "backend-https-settings"
//         #     http_listener_name         = "appgw-https-listener"
//         #     name                       = "appgw-routing-rule-001"
//         #     priority                   = 210
//         #     rule_type                  = "Basic"
//         #   }
//         # ]
//         # request_routing_rule = [
//         #   {
//         #     backend_address_pool_name  = "backend-pool"
//         #     backend_http_settings_name = "backend-https-settings"
//         #     http_listener_name         = "appgw-private-https-listener"
//         #     name                       = "appgw-private-routing-rule-001"
//         #     priority                   = 210
//         #     rule_type                  = "Basic"
//         #   }
//         # ]

//         probe = [{
//           interval                                  = 30
//           minimum_servers                           = 0
//           name                                      = "hp-backend-https"
//           path                                      = "/version"
//           pick_host_name_from_backend_http_settings = true
//           protocol                                  = "Https"
//           timeout                                   = 30
//           unhealthy_threshold                       = 3

//           match = {
//             status_code = ["200-399"]
//           }

//           }
//         ]

//         ssl_policy = {
//           policy_type          = "Custom"
//           min_protocol_version = "TLSv1_2"
//           cipher_suites = [
//             "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
//             "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
//             "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
//             "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
//             "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
//             "TLS_RSA_WITH_AES_256_GCM_SHA384",
//             "TLS_RSA_WITH_AES_256_CBC_SHA256",
//             "TLS_RSA_WITH_AES_256_CBC_SHA",
//             "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
//           ]
//         }

//  # Not there in production
//         # autoscale_configuration = {
//         #   min_capacity = 1
//         #   max_capacity = 2
//         # }
//       }
//     }
//   }
// }
