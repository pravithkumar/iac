module "avd_deployment" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source = "./modules/avd_deployment" 
  existing_resource_group_name = var.existing_resource_group_name
  existing_virtual_network_name = var.existing_virtual_network_name
  existing_subnet_name       = var.existing_subnet_name
  location                   = var.location
  host_pool_name             = var.host_pool_name
  host_pool_type             = var.host_pool_type
  load_balancer_type         = var.load_balancer_type
  max_session_hosts          = var.max_session_hosts
  default_desktop_app_group_name = var.application_group_name
  workspace_name             = var.workspace_name
  vm_size                    = var.vm_size
  admin_username             = var.admin_username
  
  
}

