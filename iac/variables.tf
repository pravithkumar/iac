variable "location" {
  type = string
}

variable "runtime" {
  type = string
}

variable "runtime_version" {
  type = string
}

variable "https_only" {
  type = bool
}

variable "always_on" {
  type = bool
}

variable "os_type" {
  type = string
}

variable "aspsku_name" {
  type = string
}

variable "worker_count" {
  type = number
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "sku" {
  type = string
}

variable "enable_managed_identity" {
  description = "Enable system-assigned managed identity for the Service Bus namespace."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access for the Service Bus namespace."
  type        = bool
  default     = false
}

variable "trusted_services_allowed" {
  description = "Allow trusted Microsoft services to bypass the firewall."
  type        = bool
  default     = true
}

variable "https_traffic_only_enabled" {
  type = bool
}

variable "identity_type" {
  type = string
}

variable "advanced_threat_protection_enabled" {
  type = bool
}

variable "tags" {
  type = map(string)
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "location_test" {
  description = "The Azure region (e.g., eastus, westus)"
  type        = string
}

variable "app_insights_resource_group_name" {
  description = "app_insights_name  RG"
  type        = string
}

variable "app_insights_name" {
  description = "app_insights_name  existing "
  type        = string
}

variable "subscription_max_delivery_count" {
  type = number
}

variable "queue_names" {
  type = list(string)
}

variable "topic_names" {
  type = list(string)
}

variable "servicebus_capacity" {
  type = number
}

variable "premium_messaging_partitions" {
  type = number
}

variable "queue_max_size" {
  type = number
}

variable "topic_max_size" {
  type = number
}

