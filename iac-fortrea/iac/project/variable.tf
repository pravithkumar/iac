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

variable "https_only" {
  type        = bool
  description = "Should only HTTPS traffic be allowed to the Logic App?"
  default     = true
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

variable "region" {
  description = "The Azure region (e.g., eastus, westus)"
  type        = string
}

variable "enable_app_insights" {
  type        = bool
  description = "Whether to enable Application Insights integration for the Function App."
  default     = false
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

variable "auth_enabled" {
  description = "Enable authentication settings"
  type        = bool
  default     = true
}


variable "allowed_external_redirect_urls" {
  description = "Allowed external redirect URLs"
  type        = list(string)
  default     = ["openid", "profile", "email"]
}

variable "client_id" {
  description = "Client ID of the Azure Active Directory application"
  type        = string
}

variable "tenant_auth_endpoint" {
  description = "Tenant authentication endpoint"
  type        = string
}

variable "security_configuration" {
  type = list(object({
    backend_ssl30_enabled                                = optional(bool, false)
    backend_tls10_enabled                                = optional(bool, false)
    backend_tls11_enabled                                = optional(bool, false)
    frontend_ssl30_enabled                               = optional(bool, false)
    frontend_tls10_enabled                               = optional(bool, false)
    frontend_tls11_enabled                               = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = optional(bool, false)
    triple_des_ciphers_enabled                          = optional(bool, false)
  }))
  default = []
}

variable "client_secret" {
  type        = string
  description = "The Client Secret of the Azure Active Directory application."
  sensitive   = true
}

