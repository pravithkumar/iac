output "configuration" {
  description = "Configuration settings for the \"management\" resources."
  value = local.configure_management_resources
}

output "subscription_id" {
  description = "Subscription ID for the \"management\" resources."
  value = var.management_subscription_id
}