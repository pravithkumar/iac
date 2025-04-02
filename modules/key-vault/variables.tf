variable "azurerm_key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "enabled_for_disk_encryption" {
  description = "Specifies whether Azure Disk Encryption is permitted."
  type        = bool
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription."
  type        = string
}

variable "soft_delete_retention_days" {
  description = "The number of days to retain deleted vaults."
  type        = number
}

variable "purge_protection_enabled" {
  description = "Specifies whether purge protection is enabled."
  type        = bool
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
}

variable "sku_name" {
  description = "The SKU name of the Key Vault."
  type        = string
}

variable "enabled_for_template_deployment" {
  description = "Specifies whether Azure Resource Manager template deployment is enabled."
  type        = bool
}

variable "enabled_for_deployment" {
  description = "Specifies whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
  type        = bool
}

variable "enable_rbac_authorization" {
  description = "Specifies whether RBAC authorization is enabled."
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Specifies whether public network access is enabled."
  type        = bool
}

variable "network_acls" {
  description = "A list of network ACLs."
  type = list(object({
    bypass                     = string
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  }))
}
