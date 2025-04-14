variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Service Bus."
}

variable "location" {
  type        = string
  description = "The Azure Region in which to create the Service Bus."
}

variable "servicebus_name" {
  type        = string
  description = "The name of the Service Bus Namespace."
}

variable "sku" {
  type        = string
  description = "The SKU of the Service Bus Namespace (Standard, Premium, or PremiumV2)."
}


variable "queue_names" {
  type    = list(string)
  default = ["queue1", "queue2"]
}

variable "topic_names" {
  type    = list(string)
  default = ["topic1", "topic2"]
}

variable "servicebus_capacity" {
  type        = number
  description = "Service Bus Namespace Capacity."
  default     = 1
}

variable "premium_messaging_partitions" {
  type        = number
  description = "Service Bus Namespace Premium Messaging Partitions."
  default     = 1
}

variable "queue_max_size" {
  type        = number
  description = "Maximum size in megabytes for queues."
  default     = 1024
}

variable "topic_max_size" {
  type        = number
  description = "Maximum size in megabytes for topics."
  default     = 1024
}

variable "subscription_max_delivery_count" {
  type        = number
  description = "Maximum delivery count for subscriptions."
  default     = 10
}

variable "identity_type" {
  description = "The type of identity to assign to the resource. Possible values are 'SystemAssigned' or 'UserAssigned'."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "The list of user-assigned identity IDs to assign to the resource. Only used if identity_type is 'UserAssigned'."
  type        = list(string)
  default     = []
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