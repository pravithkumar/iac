module "avd_deployment" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source = "../modules/avd_deployment" 
  host_pool_name             = var.host_pool_name
  host_pool_type             = var.host_pool_type
  load_balancer_type         = var.load_balancer_type
  max_session_hosts          = var.max_session_hosts
  application_group_name     = var.application_group_name
  workspace_name             = var.workspace_name
  vm_size                    = var.vm_size
  vm_image_publisher         = var.vm_image_publisher
  vm_image_offer             = var.vm_image_offer
  vm_image_sku               = var.vm_image_sku
  vm_image_version           = var.vm_image_version
  os_disk_storage_account_type = var.os_disk_storage_account_type
  os_disk_size_gb               = var.os_disk_size_gb
  #availability_type         = var.availability_type
  availability_set_id = var.availability_set_id
  zones                     = var.zones
  key_vault_name            = var.key_vault_name
  session_host_admin_username_kv_value = var.session_host_admin_username_kv_value
  session_host_admin_password_kv_value = var.session_host_admin_password_kv_value
  
  
}

