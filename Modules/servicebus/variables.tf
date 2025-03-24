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