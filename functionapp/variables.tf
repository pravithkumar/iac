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

variable "app_settings" {
  type        = map(string)
  description = "A map of application settings to apply to the Function App."
  default     = {}
}

variable "allowed_external_redirect_urls" {
  description = "Allowed external redirect URLs"
  type        = list(string)
  default     = ["openid", "profile", "email"]
}

variable "client_id" {
  description = "Client ID of the Azure Active Directory application"
  type        = string
  default     = "cfe072e8-149a-4a79-b7d6-9df55eb4aa6b"
}

variable "tenant_auth_endpoint" {
  description = "Tenant authentication endpoint"
  type        = string
  default     = "https://login.microsoftonline.com/{tenant-guid}/v2.0/"
}

