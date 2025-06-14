# Configure the connectivity resources settings.
locals {
  configure_connectivity_resources = {
    settings = {
      hub_networks = [
        {
          enabled = true
          config = {
            address_space                = ["10.100.0.0/16", ]
            location                     = var.deployment_location
            link_to_ddos_protection_plan = var.ddos_protection_plan_link
            dns_servers                  = []
            bgp_community                = "12076:20000"
            subnets                      = []
            virtual_network_gateway = {
              enabled = var.virtual_network_gateway_enable
              config = {
                address_prefix           = "10.100.1.0/24"
                gateway_sku_expressroute = var.expressroute_gateway_sku #== "empty" || var.vpn_gateway_sku != "empty"  ? "" : var.expressroute_gateway_sku
                gateway_sku_vpn          = "" #var.vpn_gateway_sku == "empty" ? "" : var.vpn_gateway_sku          
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            custom_settings_by_resource_type = {
              azurerm_public_ip = {
                connectivity_expressroute = { 
                  eastus2 = {
                    sku               = "Standard" #var.expressroute_gateway_sku != null || var.vpn_gateway_sku != null ? "Standard" : "basic"
                    allocation_method = "Static"
                  }
                }
              }
            }                        
            azure_firewall = {
              enabled = var.azure_firewall_enable
              config = {
                address_prefix                = "10.100.0.0/24"
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = var.azure_firewall_sku_tier
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = "Deny"
                threat_intelligence_allowlist = {}       
                intrusion_detection           = "Deny"
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = true
            enable_hub_network_mesh_peering         = false
          }
        },
        {
          enabled = false
          config = {
            address_space                = ["10.101.0.0/16", ]
            location                     = "centralus"
            link_to_ddos_protection_plan = false
            dns_servers                  = []
            bgp_community                = "12076:20000"
            subnets                      = []
            virtual_network_gateway = {
              enabled = false
              config = {
                address_prefix           = "10.101.1.0/24"
                gateway_sku_expressroute = ""
                gateway_sku_vpn          = "VpnGw2AZ"
                advanced_vpn_settings = {
                  enable_bgp                       = null
                  active_active                    = null
                  private_ip_address_allocation    = ""
                  default_local_network_gateway_id = ""
                  vpn_client_configuration         = []
                  bgp_settings                     = []
                  custom_route                     = []
                }
              }
            }
            custom_settings_by_resource_type = {
              azurerm_public_ip = {
                connectivity_expressroute = {
                  centralus = {
                    sku               = "Standard"
                    allocation_method = "Static"
                  }
                }
              }
            }
            custom_settings_by_resource_type = {
              azurerm_public_ip = {
                connectivity_vpn = {
                  centralus = {
                    sku               = "Standard"
                    allocation_method = "Static"
                  }
                }
              }
            }                         
            azure_firewall = {
              enabled = false
              config = {
                address_prefix                = "10.101.0.0/24"
                enable_dns_proxy              = true
                dns_servers                   = []
                sku_tier                      = "Standard" 
                base_policy_id                = ""
                private_ip_ranges             = []
                threat_intelligence_mode      = "Deny"
                threat_intelligence_allowlist = {}                 
                intrusion_detection           = "Deny"
                availability_zones = {
                  zone_1 = true
                  zone_2 = true
                  zone_3 = true
                }
              }
            }
            spoke_virtual_network_resource_ids      = []
            enable_outbound_virtual_network_peering = true
            enable_hub_network_mesh_peering         = false
          }
        },
      ]
      vwan_hub_networks = []
      ddos_protection_plan = {
        enabled = var.ddos_protection_plan_enable
        config = {
          location = var.deployment_location
        }
      }
      dns = {
        enabled = var.dns_zone_enable
        config = {
          location = var.deployment_location
          enable_private_link_by_service = {
            azure_api_management                 = true
            azure_app_configuration_stores       = true
            azure_arc                            = true
            azure_automation_dscandhybridworker  = true
            azure_automation_webhook             = true
            azure_backup                         = true
            azure_batch_account                  = true
            azure_bot_service_bot                = true
            azure_bot_service_token              = true
            azure_cache_for_redis                = true
            azure_cache_for_redis_enterprise     = true
            azure_container_registry             = true
            azure_cosmos_db_cassandra            = true
            azure_cosmos_db_gremlin              = true
            azure_cosmos_db_mongodb              = true
            azure_cosmos_db_sql                  = true
            azure_cosmos_db_table                = true
            azure_data_explorer                  = true
            azure_data_factory                   = true
            azure_data_factory_portal            = true
            azure_data_health_data_services      = true
            azure_data_lake_file_system_gen2     = true
            azure_database_for_mariadb_server    = true
            azure_database_for_mysql_server      = true
            azure_database_for_postgresql_server = true
            azure_digital_twins                  = true
            azure_event_grid_domain              = true
            azure_event_grid_topic               = true
            azure_event_hubs_namespace           = true
            azure_file_sync                      = true
            azure_hdinsights                     = true
            azure_iot_dps                        = true
            azure_iot_hub                        = true
            azure_key_vault                      = true
            azure_key_vault_managed_hsm          = true
            azure_kubernetes_service_management  = true
            azure_machine_learning_workspace     = true
            azure_managed_disks                  = true
            azure_media_services                 = true
            azure_migrate                        = true
            azure_monitor                        = true
            azure_purview_account                = true
            azure_purview_studio                 = true
            azure_relay_namespace                = true
            azure_search_service                 = true
            azure_service_bus_namespace          = true
            azure_site_recovery                  = true
            azure_sql_database_sqlserver         = true
            azure_synapse_analytics_dev          = true
            azure_synapse_analytics_sql          = true
            azure_synapse_studio                 = true
            azure_web_apps_sites                 = true
            azure_web_apps_static_sites          = true
            cognitive_services_account           = true
            microsoft_power_bi                   = true
            signalr                              = true
            signalr_webpubsub                    = true
            storage_account_blob                 = true
            storage_account_file                 = true
            storage_account_queue                = true
            storage_account_table                = true
            storage_account_web                  = true
          }
          private_link_locations = [
            "eastus2",
            "centralus",
          ]
          public_dns_zones                                       = []
          private_dns_zones                                      = []
          enable_private_dns_zone_virtual_network_link_on_hubs   = false
          enable_private_dns_zone_virtual_network_link_on_spokes = false
          virtual_network_resource_ids_to_link                   = []
        }
      }
    }

    location = var.connectivity_resources_location
    tags     = var.connectivity_resources_tags
    advanced = null
  }
}