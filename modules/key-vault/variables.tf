variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "The location where the Key Vault will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
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

variable "public_network_access" {
  description = "Enable public network access for the Key Vault."
  type        = bool
}

variable "kvsoft_delete_retention_days" {
  description = "Number of days to retain soft deleted items."
  type        = number
}

variable "kv_enabled_for_deployment" {
  description = "Enable the Key Vault for deployment."
  type        = bool
}

variable "kv_enabled_for_disk_encryption" {
  description = "Enable the Key Vault for disk encryption."
  type        = bool
}

variable "kv_enabled_for_template_deployment" {
  description = "Enable the Key Vault for template deployment."
  type        = bool
}

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

variable "tags" {
  description = "Tags to apply to the Key Vault."
  type        = map(string)
}