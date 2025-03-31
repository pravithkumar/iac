variable "function_app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_account_resource_group_name" {
  type = string
}

variable "app_insights_name" {
  type = string
}

variable "app_insights_resource_group_name" {
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

variable "tags" {
  type = map(string)
}

variable "asp_resource_group_name" {
  type = string
}

variable "asp_service_plan_name" {
  type = string
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

variable "servicebus_name" {
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

variable "private_endpoints" {
  type = list(object({
    name                = string
    subnet_id           = string
    private_dns_zone_ids = list(string)
    subresource_names   = list(string)
  }))
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

variable "subscription_max_delivery_count" {
  type = number
}

// variable "api_management_name" {
//   type = string
// }

// variable "publisher_name" {
//   type = string
// }

// variable "publisher_email" {
//   type = string
// }

// variable "api_sku" {
//   type = string
// }

// variable "sku_count" {
//   type = string
// }

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "kvsku_name" {
  description = "The SKU name of the Key Vault."
  type        = string
}

variable "kvpurge_protection_enabled" {
  description = "Enable purge protection for the Key Vault."
  type        = bool
}

variable "kvrbac_authorization" {
  description = "Enable RBAC authorization for the Key Vault."
  type        = bool
}


variable "kvsoft_delete_retention_days" {
  description = "Number of days to retain soft deleted items."
  type        = number
}

variable "enabled_for_deployment" {
  description = "Enable the Key Vault for deployment."
  type        = bool
}

variable "enabled_for_disk_encryption" {
  description = "Enable the Key Vault for disk encryption."
  type        = bool
}

variable "enabled_for_template_deployment" {
  description = "Enable the Key Vault for template deployment."
  type        = bool
}

// variable "public_network_access_enabled" {
//   description = "Enable public_network_access_enabled"
//   type        = bool
//   default     = false
// }

variable "kvnetdefaultaction" {
  description = "Default action for network ACLs."
  type        = string
}

variable "kvnetaclbypass" {
  description = "Bypass for network ACLs."
  type        = string
}

variable "kvip_rules" {
  description = "IP rules for network ACLs."
  type        = list(string)
}

variable "kvtimeoutcreate" {
  description = "Timeout for creating the Key Vault."
  type        = string
}

variable "kvtimeoutupdate" {
  description = "Timeout for updating the Key Vault."
  type        = string
}

variable "kvtimeoutdelete" {
  description = "Timeout for deleting the Key Vault."
  type        = string
}

variable "storage_accounts" {
  type = list(object({
     name                             = string
    resource_group_name              = string
    location                         = string
    account_tier                     = string
    account_replication              = string
    private_endpoint_name            = string
    subnet_id                        = string
    private_dns_zone_ids             = list(string)
    subresource_names                = list(string)
    public_network_access_enabled    = bool
    https_traffic_only_enabled       = bool
    identity_type                    = string
    advanced_threat_protection_enabled = bool
  }))
}