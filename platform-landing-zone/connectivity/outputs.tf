# Output a copy of configure_connectivity_resources.

output "configuration" {
  description = "Configuration settings for the \"connectivity\" resources."
  value       = local.configure_connectivity_resources
}

output "subscription_id" {
  description = "Subscription ID for the \"connectivity\" resources."
  value       = var.connectivity_subscription_id
}