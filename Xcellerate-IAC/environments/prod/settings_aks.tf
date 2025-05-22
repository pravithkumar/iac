locals {
  configure_aks_resources = {

    settings = {

      "aks-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                       = "aks-${var.app_name}-${var.environment}-${var.location}-001"
        location                   = var.location
        resource_group_name        = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        kubernetes_version         = "1.30"
        sku_tier                   = "Standard"
        private_cluster_enabled    = true
        private_dns_zone_id        = data.azurerm_private_dns_zone.privatelink_eastus_azmk8s_io.id
        dns_prefix_private_cluster = "aks-${var.app_name}-${var.environment}-${var.location}-001"
        tags                       = var.tags
        os_disk_size_gb            = 128
        oidc_issuer_enabled        = true
        acrid                      = module.acr.acrxlprodeastus001.acr_id
        workload_identity_enabled  = true
        local_account_disabled     = true
        azure_policy_enabled       = true
        # node_os_channel_upgrade    = "SecurityPatch"
        # maintenance_window_node_os = {
        #   duration    = 4
        #   frequency   = "RelativeMonthly"
        #   interval    = 1
        #   day_of_week = "Wednesday"
        #   utc_offset  = "+04:00"
        #   start_date  = "2024-08-21T03:00:00Z"
        #   start_time  = "03:00"
        #   week_index  = "Fourth"
        # }

        oms_agent = {
          log_analytics_workspace_id      = data.azurerm_log_analytics_workspace.this.id
          msi_auth_for_monitoring_enabled = true
        }

        default_node_pool = {
          name                        = "systempool"
          node_count                  = 3
          min_count                   = 3
          max_count                   = 10
          vm_size                     = "Standard_D2ds_v4"
          max_pods                    = 120
          vnet_subnet_id              = data.azurerm_subnet.snet_xl_prod_aks_001.id
          temporary_name_for_rotation = "tempsyspool"
          #enable_host_encryption      = true
          auto_scaling_enabled = true
          zones                = ["1", "2", "3"]
          node_labels = {
            "type" = "system"
          }

          upgrade_settings = {
            drain_timeout_in_minutes      = 0
            max_surge                     = "5%"
            node_soak_duration_in_minutes = 0
          }

        }

        key_vault_secrets_provider = {
          secret_rotation_enabled  = true
          secret_rotation_interval = "2m"
        }

        # storage_profile = {
        #   blob_driver_enabled         = true
        #   disk_driver_enabled         = true
        #   disk_driver_version         = "v1"
        #   file_driver_enabled         = true
        #   snapshot_controller_enabled = true
        # }

        identity = {
          type         = "UserAssigned"
          identity_ids = [module.managed_identity.id]
        }

        azure_active_directory_role_based_access_control = {
          managed                = true
          azure_rbac_enabled     = true
          admin_group_object_ids = [data.azurerm_client_config.this.client_id]
        }

        # api_server_access_profile = {

        #   subnet_id = "/subscriptions/${local.subscription_id}/resourceGroups/${local.rg_infra}/providers/Microsoft.Network/virtualNetworks/vnet-adqcc-prd-m42-aen/subnets/snet-app-prd-m42-aen"
        #   vnet_integration_enabled = true
        # }

        # web_app_routing = {
        #   dns_zone_ids = "/subscriptions/29d43faa-10c8-436c-849e-d0d9c1e03a6f/resourceGroups/rg-dns-prod-001/providers/Microsoft.Network/privateDnsZones/privatelink.eastus.azmk8s.io"
        # }

        network_profile = {
          outbound_type       = "userDefinedRouting"
          service_cidr        = "172.17.0.0/16"
          dns_service_ip      = "172.17.0.100"
          pod_cidr            = "172.16.0.0/16"
          network_policy      = "azure"
          network_plugin      = "azure"
          network_plugin_mode = "overlay"
          load_balancer_sku   = "standard"

          # load_balancer_profile = {
          #   idle_timeout_in_minutes = 15
          #   managed_outbound_ip_count = 0
          #   #managed_outbound_ipv6_count = 
          #   outbound_ip_address_ids = []
          #   outbound_ip_prefix_ids = []
          #   outbound_ports_allocated = 0
          # }
        }

        kubernetes_cluster_node_pool = [
          {
            name                 = "userpool"
            vm_size              = "Standard_D2ds_v4"
            auto_scaling_enabled = true
            #enable_host_encryption = true
            os_disk_size_gb = 150
            node_count      = 3
            min_count       = 3
            max_count       = 5
            max_pods        = 30
            zones           = ["1", "2", "3"]
            vnet_subnet_id  = data.azurerm_subnet.snet_xl_prod_aks_001.id

            node_labels = {
              "type" = "user"
            }

            upgrade_settings = {
              drain_timeout_in_minutes      = 0
              max_surge                     = "5%"
              node_soak_duration_in_minutes = 0
            }
          }
        ]
      }
    }
  }
}
