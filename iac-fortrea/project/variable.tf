variable "location" {
  type = string
}

variable "runtime" {
  type = string
}

variable "runtime_version" {
  type = string
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

variable "enable_app_insights" {
  type        = bool
  description = "Whether to enable Application Insights integration for the Function App."
  default     = false
}

// variable "app_insights_resource_group_name" {
//   description = "app_insights_name  RG"
//   type        = string
// }

// variable "app_insights_name" {
//   description = "app_insights_name  existing "
//   type        = string
// }

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

variable "internal_load_balancing_mode" {
  description = "The internal load balancing mode"
  type        = string
}
variable "disable_tls1_0" {
  description = "Disable TLS 1.0 setting"
  type        = string
  default     = "1"
}
variable "internal_encryption" {
  description = "Internal encryption setting"
  type        = string
  default     = "true"
}
variable "frontend_ssl_cipher_suite_order" {
  description = "Front-end SSL cipher suite order"
  type        = string
  default     = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
}

variable "publisher_name" {
  type = string
}

variable "publisher_email" {
  type = string
}

variable "api_sku" {
  type = string
}

variable "sku_count" {
  type = string
}

variable "app_settings" {
  type        = map(string)
  description = "A map of application settings to apply to the Function App."
  default     = {}
}

