variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "location" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "https_traffic_only_enabled" {
  type    = bool
  default = true
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

variable "advanced_threat_protection_enabled" {
  type    = bool
  default = true
}

variable "tags" {
  type = map(string)
}

// Uncomment if you want to enable soft delete
// variable "delete_retention_days" {
//   type    = number
//   default = 1
// }

// variable "container_delete_retention_days" {
//   type    = number
//   default = 1
// }