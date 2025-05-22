locals {
  configure_data_collection_rule_resources = {
    settings = {
      "MSCI-${var.location}-aks-${var.app_name}-${var.environment}-${var.location}-001" = {
        name                        = "MSCI-${var.location}-aks-${var.app_name}-${var.environment}-${var.location}-001"
        resource_group_name         = "rg-${var.app_name}-${var.environment}-${var.location}-001"
        data_collection_endpoint_id = data.azurerm_monitor_data_collection_endpoint.dce_ampls_centralized_eastus_001.id
        location                    = var.location
        tags                        = var.tags

        destinations = {
          log_analytics = [
            {
              name                  = "ciworkspace"
              workspace_resource_id = data.azurerm_log_analytics_workspace.this.id
            }
          ]
        }

        data_flow = [
          {
            streams      = ["Microsoft-ContainerInsights-Group-Default"]
            destinations = ["ciworkspace"]
          }
        ]

        data_sources = {
          extension = [
            {
              name           = "ContainerInsightsExtension"
              streams        = ["Microsoft-ContainerInsights-Group-Default"]
              extension_name = "ContainerInsights"
              extension_json = jsonencode({
                dataCollectionSettings = {
                  enableContainerLogV2   = true
                  interval               = "1m"
                  namespaceFilteringMode = "Off"
                }
              })
            }
          ]
        }

        data_collection_rule_association = concat([
          for cluster in [
            data.azurerm_kubernetes_cluster.aks_xl_prod_eastus_001.id,   #enabled insights
            ] : {
            name               = basename(cluster)
            target_resource_id = cluster
          }
        ])
      }


    }
  }
}
