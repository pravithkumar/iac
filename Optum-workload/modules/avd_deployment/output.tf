output "host_pool_name" {
  description = "The name of the deployed AVD Host Pool."
  value       = module.avd_deployment.host_pool_name
}

output "workspace_name" {
  description = "The name of the AVD Workspace."
  value       = module.avd_deployment.workspace_name
}

output "nic_id" {
  value       = module.avd_deployment.nic.id
  description = "The ID of the created Network Interface Card."
}