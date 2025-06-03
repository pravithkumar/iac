output "resource_group_name" {
  description = "The ID of the existing Resource Group."
  value       = data.azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "The ID of the existing Virtual Network."
  value       = data.azurerm_virtual_network.vnet.id
}

output "subnet_id" {
  description = "The ID of the existing Subnet."
  value       = data.azurerm_subnet.subnet.id
}
