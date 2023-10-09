data "azurerm_resource_group" "AksRG" {
  name = var.resource_group_name
}
data "azurerm_resource_group" "VntRG" {
  name = var.Vnet_resource_group_name
}
data "azurerm_user_assigned_identity" "aksumi" {
  name                = "umi-pega-uat-001"
  resource_group_name = data.azurerm_resource_group.AksRG.name 
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = var.aksname
  location            = data.azurerm_resource_group.AksRG.location
  resource_group_name = data.azurerm_resource_group.AksRG.name
  dns_prefix          = var.dnsprefix
  role_based_access_control_enabled = true
  private_cluster_enabled = true
  private_dns_zone_id = var.private_dns_zone_id    
  public_network_access_enabled = false
  kubernetes_version = "1.23.5"

  default_node_pool {
    name            = var.nodepoolname
    node_count      = var.nodecount
    vm_size         = var.vmsize
    os_disk_type    = "Managed" 
    os_disk_size_gb = var.osdisksize
    max_pods        = var.maxpods
    enable_auto_scaling = var.autoscale
    max_count = var.maxcount
    min_count = var.mincount
    vnet_subnet_id = var.subnetid
  } 
  
 
  identity {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.aksumi.id]    
  }

    network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "azure"
    network_policy     = "azure"
  }
  dynamic "microsoft_defender"{
    for_each = var.EnableMSDefender == true ? [var.MSDefenderLAID]:[]
    content{
      log_analytics_workspace_id = microsoft_defender.value
    }
  }
}


  
