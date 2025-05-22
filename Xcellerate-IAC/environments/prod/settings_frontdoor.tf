locals {
  configure_frontdoor_resources = {

    settings = {

      "afd-${var.app_name}-${var.environment}-${var.location}-001" = {
        profile = {
          name                = "afd-${var.app_name}-${var.environment}-${var.location}-001"
          resource_group_name = "rg-${var.app_name}-${var.environment}-${var.location}-001"
          sku_name            = "Standard_AzureFrontDoor"
          identity = {
            type         = "UserAssigned"
            identity_ids = [module.managed_identity.id]
          }
        }

        endpoint = {
          name    = "${var.app_name}-${var.environment}-endpoint"
          enabled = true
        }

        # endpoints = [
        #   {
        #     name    = "ve-storage-qa"
        #     enabled = true
        #   },
        #   {
        #     name    = "smarttv-webapp-dev"
        #     enabled = true
        #   },
        #   {
        #     name    = "gucamole"
        #     enabled = true
        #   },
        #   {
        #     name    = "xl-prod-apim"
        #     enabled = true
        #   }

        # ]

        # azurerm_cdn_frontdoor_security_policy = {
        #   cdn_frontdoor_domain_id = "/subscriptions/06b4c274-4cdc-4912-b3f5-75db6d9e9126/resourceGroups/rg-zee5-np-ci1-hubconnectivity-0001/providers/Microsoft.Cdn/profiles/afd-zee5-np-hub-0001/afdEndpoints/zee5np-endpoint"
        # }
        # # Create origin grpups before orgin
        # origin_groups = [

        #   {
        #     name = "VE-Storage-QA"
        #     health_probe = {
        #       interval_in_seconds = 100
        #       path                = "/"
        #       protocol            = "Https"
        #       request_type        = "HEAD"
        #     }
        #     load_balancing = {
        #       additional_latency_in_milliseconds = 50
        #       sample_size                        = 4
        #       successful_samples_required        = 3
        #     }
        #   },
        #   {
        #     name = "Guacomole-NP"

        #     load_balancing = {
        #       additional_latency_in_milliseconds = 50
        #       sample_size                        = 4
        #       successful_samples_required        = 3
        #     }
        #   },
        #   {
        #     name = "Aqilliz-Api-Np-OG"

        #     load_balancing = {
        #       additional_latency_in_milliseconds = 50
        #       sample_size                        = 4
        #       successful_samples_required        = 3
        #     }
        #   },

        # ]


        # # create origins after origins group
        # origins = [


        #   {
        #     name                           = "VE-Storage-QA"
        #     origin_group_name              = "VE-Storage-QA"
        #     enabled                        = true
        #     certificate_name_check_enabled = true
        #     host_name                      = "stzee5qaci1ve0001.blob.core.windows.net"
        #     http_port                      = 80
        #     https_port                     = 443
        #     origin_host_header             = "stzee5qaci1ve0001.blob.core.windows.net"
        #     priority                       = 1
        #     weight                         = 1000

        #     private_link = {
        #       location               = "centralindia"
        #       private_link_target_id = "/subscriptions/93d7fd7e-3393-4ac8-af39-6898264b1f36/resourceGroups/rg-${local.common.bu_name}-${local.common.dep_env_qa}-ci1-ve-0001/providers/Microsoft.Storage/storageAccounts/stzee5qaci1ve0001"
        #       request_message        = "From_FrontDoor"
        #       target_type            = "blob"
        #     }
        #   },

        #   {
        #     name                           = "Guacomole-NP"
        #     origin_group_name              = "Guacomole-NP"
        #     enabled                        = true
        #     certificate_name_check_enabled = true
        #     host_name                      = "10.171.42.251"
        #     http_port                      = 80
        #     https_port                     = 443
        #     origin_host_header             = "10.171.42.251"
        #     priority                       = 1
        #     weight                         = 1000

        #     private_link = {
        #       location               = "centralindia"
        #       private_link_target_id = "/subscriptions/075e61b7-0274-436e-85df-3fe6f5fb33a1/resourceGroups/rg-its-np-ci1-jmp-0001/providers/Microsoft.Network/privateLinkServices/plink-its-np-ci1-gua-0001"
        #       request_message        = "Frontdoor-Guacomole-EPT"

        #     }
        #   },

        #   {
        #     name                           = "Aqilliz-Api-Np-OG-originlb"
        #     origin_group_name              = "Aqilliz-Api-Np-OG"
        #     enabled                        = true
        #     certificate_name_check_enabled = false
        #     host_name                      = "20.219.15.109"
        #     http_port                      = 80
        #     https_port                     = 443
        #     origin_host_header             = "20.219.15.109"
        #     priority                       = 1
        #     weight                         = 1000
        #   },


        # ]

        # #create rule sets before rules
        # rule_sets = [
        #   {
        #     name = "CORSPolicy"
        #   },
        #   {
        #     name = "uapiQArule"
        #   },
        #   {
        #     name = "uapiUATrule"
        #   },
        #   {
        #     name = "uapirule"
        #   },
        #   {
        #     name = "AFDVEStorageQA"
        #   },
        #   {
        #     name = "AFDCMSStoragedev"
        #   },
        #   {
        #     name = "AFDCMSStorageUAT"
        #   },
        #   {
        #     name = "AFDCMSStorageQA"
        #   },
        # ]


        # frontdoor_rules = [
        #   {
        #     name          = "AFDCMSStorageQA"
        #     rule_set_name = "AFDCMSStorageQA"
        #     order         = 1

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/{url_path}?sv=2022-11-02&ss=bfqt&srt=so&sp=rltfx&se=2024-06-30T13:35:42Z&st=2024-03-07T05:35:42Z&spr=https&sig=H%2Bh1s4nTZ43hyZwca4ShSR2U3lPK6GGE8YMEOA9MyyY%3D"
        #         preserve_unmatched_path = false
        #         source_pattern          = "/{url_path}"
        #       }]
        #     }]

        #     conditions = [{
        #       request_method_condition = [{
        #         match_values     = ["GET", "HEAD"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #       request_scheme_condition = [{
        #         match_values     = ["HTTPS"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #     }]
        #   },
        #   {
        #     name          = "AFDCMSStorageUAT"
        #     rule_set_name = "AFDCMSStorageUAT"
        #     order         = 1

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/{url_path}?sv=2022-11-02&ss=bfqt&srt=sco&sp=rwdlacupiytfx&se=2024-06-15T18:01:45Z&st=2024-02-15T10:01:45Z&spr=https&sig=Qkppbbtjy3DW1tyImVcGQoE%2BEk6tguDGFVyiJ2w2R98%3D"
        #         preserve_unmatched_path = false
        #         source_pattern          = "/{url_path}"
        #       }]
        #     }]

        #     conditions = [{
        #       request_method_condition = [{
        #         match_values     = ["OPTIONS", "GET", "HEAD"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #       request_scheme_condition = [{
        #         match_values     = ["HTTPS"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #     }]
        #   },
        #   {
        #     name          = "AFDCMSStoragedev"
        #     rule_set_name = "AFDCMSStoragedev"
        #     order         = 1

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/{url_path}?sv=2022-11-02&ss=bfqt&srt=sco&sp=rltfx&se=2024-06-30T01:33:48Z&st=2024-03-07T17:33:48Z&spr=https&sig=j%2FpZaxQROlvLjfVJlfyQbXs%2BNknrTpCVwH5f2Fv4IJY%3D"
        #         preserve_unmatched_path = false
        #         source_pattern          = "/{url_path}"
        #       }]
        #     }]

        #     conditions = [{
        #       request_method_condition = [{
        #         match_values     = ["GET", "HEAD"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #       request_scheme_condition = [{
        #         match_values     = ["HTTPS"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #     }]
        #   },
        #   {
        #     name          = "AFDVEStorageQA"
        #     rule_set_name = "AFDVEStorageQA"
        #     order         = 0

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/{url_path}?sp=r&st=2024-01-31T10:52:38Z&se=2024-02-29T18:52:38Z&spr=https&sv=2022-11-02&sr=c&sig=%2B8%2BD5ldTjb2LlWfhKaPnM3WGkmt3p5C0YsGPodrJeCY%3D"
        #         preserve_unmatched_path = false
        #         source_pattern          = "/{url_path}"
        #       }]
        #     }]

        #     conditions = [{
        #       request_scheme_condition = [{
        #         match_values     = ["HTTPS"]
        #         negate_condition = false
        #         operator         = "Equal"
        #       }]
        #     }]
        #   },
        #   {
        #     name          = "CORS"
        #     rule_set_name = "CORSPolicy"
        #     order         = 0

        #     actions = [{
        #       response_header_action = [{
        #         header_action = "Overwrite"
        #         header_name   = "Access-Control-Allow-Origin"
        #         value         = "zee5np-endpoint-hsczh4c7f9ahg3cx.z01.azurefd.net"
        #       }]
        #     }]

        #     conditions = [{

        #       request_header_condition = [{
        #         header_name = "Origin"
        #         match_values = [
        #           "zee5np-endpoint-hsczh4c7f9ahg3cx.z01.azurefd.net",
        #           "https://apim-${local.common.bu_name}-${local.common.dep_env_dv}-ci1-csvc-0001.azure-api.net"
        #         ]
        #         negate_condition = false
        #         operator         = "Contains"
        #         transforms       = []
        #       }]

        #     }]
        #   },
        #   {
        #     name          = "uapiQArule"
        #     rule_set_name = "uapiQArule"
        #     order         = 0

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/uapinodeservice/uapi/v1/user/getdeviceuser"
        #         preserve_unmatched_path = true
        #         source_pattern          = "/"
        #       }]
        #     }]

        #     conditions = [{

        #       request_uri_condition = [{
        #         match_values = [
        #           "uapinodeservice/uapi/useraction/device/getdeviceuser"
        #         ]
        #         negate_condition = false
        #         operator         = "Contains"
        #         transforms       = []
        #       }]

        #     }]
        #   },
        #   {
        #     name          = "uapiUATrule"
        #     rule_set_name = "uapiUATrule"
        #     order         = 0

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/uapinodeservice/uapi/v1/user/getdeviceuser"
        #         preserve_unmatched_path = true
        #         source_pattern          = "/"
        #       }]
        #     }]

        #     conditions = [{
        #       request_uri_condition = [{
        #         match_values = [
        #           "uapinodeservice/uapi/useraction/device/getdeviceuser"
        #         ]
        #         negate_condition = false
        #         operator         = "Contains"
        #         transforms       = []
        #       }]
        #     }]
        #   }
        #   ,
        #   {
        #     name          = "uapirule"
        #     rule_set_name = "uapirule"
        #     order         = 1

        #     actions = [{
        #       url_rewrite_action = [{
        #         destination             = "/uapinodeservice/uapi/v1/user/getdeviceuser"
        #         preserve_unmatched_path = true
        #         source_pattern          = "/"
        #       }]
        #     }]

        #     conditions = [{
        #       request_uri_condition = [{
        #         match_values = [
        #           "uapinodeservice/uapi/useraction/device/getdeviceuser"
        #         ]
        #         negate_condition = false
        #         operator         = "Contains"
        #         transforms       = []
        #       }]

        #     }]
        #   }



        # ]

        # frontdoor_secrets = [{
        #   name                     = "kv-${local.common.bu_name}-${local.common.dep_env}-ci1-hub-0001-wildcardazottinpfx-latest"
        #   key_vault_certificate_id = data.azurerm_key_vault_certificate.this.versionless_id
        #   order                    = 1
        #   # subject_alternative_names = ["*.azott.in", "azott.in"]
        # }]



        # custom_domains = [


        #   {
        #     name        = "aqilliz-api-np-azott-in"
        #     host_name   = "aqilliz-api-np.azott.in"
        #     dns_zone_id = "/subscriptions/0bb777e9-f492-4d74-b0fc-77f0d0f381ed/resourceGroups/rg-zeedigital-np-ci1-hubdns-0001/providers/Microsoft.Network/dnsZones/azott.in"
        #     tls = {
        #       certificate_type = "ManagedCertificate"
        #     }
        #   }
        # ]

        # routes = [

        #   {
        #     name                          = "Aqilliz-Api-Np-Route"
        #     frontdoor_endpoint_name       = "Aqilliz-API-NP"
        #     frontdoor_origin_group_name   = "Aqilliz-Api-Np-OG"
        #     frontdoor_custom_domain_names = ["aqilliz-api-np-azott-in"]
        #     enabled                       = true
        #     forwarding_protocol           = "MatchRequest"
        #     patterns_to_match             = ["/*"]
        #     supported_protocols           = ["Http", "Https"]
        #     https_redirect_enabled        = false
        #     link_to_default_domain        = true
        #   },



        #   {
        #     name                        = "guacomole-route"
        #     frontdoor_endpoint_name     = "gucamole"
        #     frontdoor_origin_group_name = "Guacomole-NP"
        #     enabled                     = true
        #     forwarding_protocol         = "HttpOnly"
        #     patterns_to_match           = ["/*"]
        #     supported_protocols         = ["Http", "Https"]
        #     https_redirect_enabled      = true
        #     link_to_default_domain      = true
        #   },


        #   {
        #     name                        = "ve-storage-qa"
        #     frontdoor_endpoint_name     = "ve-storage-qa"
        #     frontdoor_origin_group_name = "VE-Storage-QA"
        #     frontdoor_rule_set_names    = ["AFDVEStorageQA"]
        #     enabled                     = true
        #     forwarding_protocol         = "MatchRequest"
        #     patterns_to_match           = ["/*"]
        #     supported_protocols         = ["Http", "Https"]
        #     https_redirect_enabled      = true
        #     link_to_default_domain      = true
        #   },


        # ]


        # firewall = {
        #   name                = "wafzee5npci1afd0001"
        #   resource_group_name = "rg-${local.common.bu_name}-${local.common.dep_env}-ci1-hubconnectivity-0001"
        #   location            = "centralindia"
        #   mode                = "Prevention"
        #   enabled             = true
        #   custom_rule         = []
        # }
        # managed_rule = [
        #   {
        #     type    = ""
        #     version = "1.0"
        #   },
        #   {
        #     type    = "Microsoft_BotManagerRuleSet"
        #     version = "1.0"
        #   }
        # ]
        # tags = {
        #   "service-name"       = ""
        #   "BusinessUnit"       = ""
        #   "CostCenter"         = ""
        #   "DisasterRecovery"   = ""
        #   "environment"        = ""
        #   "OwnerName"          = ""
        #   "servicecriticality" = ""
        #   "ISV"                = ""
        #   "DataClassification" = ""
        #   "service-family"     = ""
        #   "ticket-id"          = ""
        #   "lead-spoc"          = ""
        #   "created_by"         = ""
        #   "Created_Date"       = ""
        #   "Updated_Date"       = ""
        # }
      }

      # "afd-${local.common.bu_name}-${local.common.dep_env}-hub-adtek-0001" = {
      #   profile = {
      #     name                = "afd-${local.common.bu_name}-${local.common.dep_env}-hub-adtek-0001"
      #     resource_group_name = "rg-${local.common.bu_name}-${local.common.dep_env}-ci1-hubconnectivity-0001"
      #     sku_name            = "Premium_AzureFrontDoor"
      #   }

      #   endpoint = {
      #     name    = "zee5np-adtek-endpoint"
      #     enabled = true
      #   }

      #   firewall = {
      #     name                = "wafzee5npci1afdadtek0001"
      #     resource_group_name = "rg-${local.common.bu_name}-${local.common.dep_env}-ci1-hubconnectivity-0001"
      #     location            = "centralindia"
      #     mode                = "Prevention"
      #     enabled             = true
      #     custom_rule         = []
      #   }
      #   tags = {
      #     "service-name"       = ""
      #     "BusinessUnit"       = ""
      #     "CostCenter"         = ""
      #     "DisasterRecovery"   = ""
      #     "environment"        = ""
      #     "OwnerName"          = ""
      #     "servicecriticality" = ""
      #     "ISV"                = ""
      #     "DataClassification" = ""
      #     "service-family"     = ""
      #     "ticket-id"          = ""
      #     "lead-spoc"          = ""
      #     "created_by"         = ""
      #     "Created_Date"       = ""
      #     "Updated_Date"       = ""
      #   }
      # }
    }
  }
}
