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

variable "account_kind" {
  description = "The kind of storage account."
  type        = string
  default     = "StorageV2"
}


variable "access_tier" {
  description = "The access tier for the storage account."
  type        = string
  default     = "Hot"
}



variable "shared_access_key_enabled" {
  description = "Enable shared access key."
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "Enable large file share."
  type        = bool
  default     = true
}


variable "default_to_oauth_authentication" {
  description = "Default to OAuth authentication."
  type        = bool
  default     = true
}


variable "delete_retention_days" {
  description = "Number of days to retain a blob after deletion."
  type        = number
  default     = 7
}

variable "permanent_delete_enabled" {
  description = "Enable permanent delete retention."
  type        = bool
  default     = false
}

variable "container_delete_retention_days" {
  description = "Number of days to retain a container after deletion."
  type        = number
  default     = 7
}
