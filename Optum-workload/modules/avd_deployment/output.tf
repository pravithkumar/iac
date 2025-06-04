output "resource_group_location" {
  value       = data.azurerm_resource_group.rg.location
  description = "The location of the existing Azure Resource Group."
}

output "resource_group_name" {
  value       = data.azurerm_resource_group.rg.name
  description = "The name of the existing Azure Resource Group."
}



output "host_pool_name" {
  description = "The name of the deployed AVD Host Pool."
  value       = azurerm_virtual_desktop_host_pool.avd-host-pool.name
}

output "workspace_name" {
  description = "The name of the AVD Workspace."
  value       = azurerm_virtual_desktop_workspace.avd_workspace.name
}
output "workspace_id" {
  description = "The name of the AVD Workspace."
  value       = azurerm_virtual_desktop_workspace_application_group_association.workspace_grp_assc.id
}

output "subnet_id" {
  description = "The name of the AVD Workspace."
  value       = azurerm_subnet.subnet.id
}

output "nic_id" {
  description = "The ID of the created Network Interface Card."
  value       = azurerm_network_interface.nic.id
}