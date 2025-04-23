variable "api_management_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "publisher_name" {
  type = string
}

variable "publisher_email" {
  type = string
}

variable "sku" {
  type = string
}

variable "sku_count" {
  type = string
}

variable "tags" {
  type = map(string)
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

variable "app_insights_id" {
  type        = string
  description = "The resource ID of the Application Insights instance"
}

variable "app_insights_key" {
  type        = string
  description = "The instrumentation key of the Application Insights instance"
  sensitive   = true
}

variable "client_id" {
  type        = string
  description = "The Client ID of the Azure Active Directory application."
  sensitive   = true
}

variable "client_secret" {
  type        = string
  description = "The Client Secret of the Azure Active Directory application."
  sensitive   = true
}

variable "allowed_tenants" {
  type        = list(string)
  description = "A list of tenant IDs that will be allowed to sign in."
  default     = []
}