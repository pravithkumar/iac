output "nic_id" {
  value       = azurerm_network_interface.example_nic.id
  description = "The ID of the created Network Interface Card."
}