variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "kvskuname" {
  description = "The SKU name of the Key Vault"
  type        = string
  default     = "standard"
}

variable "kvpurge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = true
}

variable "kvrbac_authorization" {
  description = "Enable RBAC authorization"
  type        = bool
  default     = false
}

variable "kvsoft_delete_retention_days" {
  description = "Soft delete retention days"
  type        = number
  default     = 7
}

variable "enabled_for_deployment" {
  description = "Enable Key Vault for deployment"
  type        = bool
  default     = false
}

variable "enabledfordiskencryption" {
  description = "Enable Key Vault for disk encryption"
  type        = bool
  default     = false
}

variable "enabledfortemplatedeployment" {
  description = "Enable Key Vault for template deployment"
  type        = bool
  default     = false
}

variable "kvnetdefaultaction" {
  description = "Default action for network ACLs"
  type        = string
  default     = "Deny"
}

variable "kvnetaclbypass" {
  description = "Bypass for network ACLs"
  type        = string
  default     = "AzureServices"
}

variable "kvip_rules" {
  description = "IP rules for network ACLs"
  type        = list(string)
  default     = []
}

variable "kvtimeoutcreate" {
  description = "Timeout for creating the Key Vault"
  type        = string
  default     = "30m"
}

variable "kvtimeoutupdate" {
  description = "Timeout for updating the Key Vault"
  type        = string
  default     = "30m"
}

variable "kvtimeoutdelete" {
  description = "Timeout for deleting the Key Vault"
  type        = string
  default     = "30m"
}

variable "tags" {
  description = "Tags for the Key Vault"
  type        = map(string)
  default     = {}
}

