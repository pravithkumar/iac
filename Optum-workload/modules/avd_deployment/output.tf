output "host_pool_name" {
  description = "The name of the deployed AVD Host Pool."
  value       = azurerm_virtual_desktop_host_pool.avd-host-pool.host_pool_name
}

output "workspace_name" {
  description = "The name of the AVD Workspace."
  value       = azurerm_virtual_desktop_workspace.avd_workspace.workspace_name
}

output "nic_id" {
  description = "The ID of the created Network Interface Card."
  value       = azurerm_network_interface.nic.id
}