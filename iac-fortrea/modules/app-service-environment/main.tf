resource "azurerm_app_service_environment_v3" "ase" {
  name                          = var.ase_name
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  internal_load_balancing_mode  = var.internal_load_balancing_mode
  
  dynamic "cluster_setting" {
    for_each = var.cluster_settings
    content {
      name  = cluster_setting.key
      value = cluster_setting.value
      }
  }
  tags = var.tags
}