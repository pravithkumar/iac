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
        private_dns_zone_id        = data.azurerm_private_dns_zone.privatelink_azmk8s_io.id
        dns_prefix_private_cluster = "aks-${var.app_name}-${var.environment}-${var.location}-001"
        tags                       = var.tags
        os_disk_size_gb            = 128
        oidc_issuer_enabled        = true
        acrid                      = module.acr["acr${var.app_name}${var.environment}${var.location}001"].acr_id
        workload_identity_enabled  = true
        local_account_disabled     = true
        azure_policy_enabled       = true

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
          vnet_subnet_id              = data.azurerm_subnet.snet_aks.id
          temporary_name_for_rotation = "tempsyspool"
          auto_scaling_enabled        = true
          zones                       = ["1", "2", "3"]
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

        identity = {
          type         = "UserAssigned"
          identity_ids = [module.managed_identity["mi-${var.app_name}-${var.environment}-${var.location}-001"].id]
        }

        azure_active_directory_role_based_access_control = {
          managed                = true
          azure_rbac_enabled     = true
          admin_group_object_ids = [data.azurerm_client_config.this.client_id]
        }

        network_profile = {
          outbound_type       = "userDefinedRouting"
          service_cidr        = "172.17.0.0/16"
          dns_service_ip      = "172.17.0.100"
          pod_cidr            = "172.16.0.0/16"
          network_policy      = "azure"
          network_plugin      = "azure"
          network_plugin_mode = "overlay"
          load_balancer_sku   = "standard"
        }

        kubernetes_cluster_node_pool = [
          {
            name                 = "userpool"
            vm_size              = "Standard_D2ds_v4"
            auto_scaling_enabled = true
            os_disk_size_gb      = 150
            node_count           = 3
            min_count            = 3
            max_count            = 5
            max_pods             = 30
            zones                = ["1", "2", "3"]
            vnet_subnet_id       = data.azurerm_subnet.snet_aks.id

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
