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
  type    = string
  default = "SystemAssigned"
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