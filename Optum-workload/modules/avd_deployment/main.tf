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

#-----AVD workspace (Desktop)-------#

resource "azurerm_virtual_desktop_workspace" "avd_workspace" {
  name                = var.workspace_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

#------AVD Host Pool -----#

resource "azurerm_virtual_desktop_host_pool" "avd-host-pool" {
  name                      = var.host_pool_name
  resource_group_name       = data.azurerm_resource_group.rg.name
  location                  = data.azurerm_resource_group.rg.location
  type                      = var.host_pool_type
  load_balancer_type        = var.load_balancer_type
  maximum_sessions_allowed  = var.max_session_hosts
  description               = "AVD Host pool with no session host config"
}











