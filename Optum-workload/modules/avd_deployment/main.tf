data "azurerm_resource_group" "rg" {
  name = var.existing_resource_group_name
  location = var.location
  }

data "azurerm_virtual_network" "vnet" {
  name      = var.existing_virtual_network_name
  resource_group_name = "data.azurerm_resource_group.rg.name"
}

data "azurerm_subnet" "subnet" {
  name    = var.existing_subnet_name
  virtual_network_name    = "data.azurerm_virtual_network.vnet.name"
  resource_group_name = "data.azurerm_resource_group.rg.name"
}



#------AVD Host Pool -----#

resource "azurerm_virtual_desktop_host_pool" "avd-host-pool" {
  name                      = var.host_pool_name
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  type                      = var.host_pool_type
  load_balancer_type        = var.load_balancer_type
  maximum_sessions_allowed  = var.max_session_hosts
  validate_environment      = true
  description               = "AVD Host pool with no session host config"
}

#-----AVD workspace-------#

resource "azurerm_virtual_desktop_workspace" "avd_workspace" {
  name                = var.workspace_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

#-------AVD Application Group (Desktop)------#

resource "azurerm_virtual_desktop_application_group" "app_group" {
  name                = var.application_group_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  type                = "Desktop" 
  host_pool_id        = azurerm_virtual_desktop_host_pool.avd-host-pool.id
  description         = "AVD Desktop Application Group"
}

#---------AVD Workspace application group association--#

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspace_grp_assc" {
  workapce_id           = azurerm_virtual_desktop_workspace.avd_workspace.id
  application_group_id  = azurerm_virtual_desktop_application_group.app_group.id
}













