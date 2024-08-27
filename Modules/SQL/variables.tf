variable "resource_group_name" {
  type        = string
  description = "Name of the resource group for VM"
}

variable "vnet_name" {
  type        = string
  description = "Name of the Vnet"
}

variable "vnet_rg_name" {
  type        = string
  description = "Name of the resource group of VNET"
}

variable "subnet_name_db" {
  type        = string
  description = "Name of DB Subnet"
}

variable "subnet_name_mgmt" {
  type = string
  description = "Name of Management Subnet"
}

variable "subnet_name_pure" {
  type = string
  description = "Name of iscsi(pure) Subnet"
}

variable "bootdiag_storage_account_name" {
  type        = string
  description = "Name of the Storage Account"
}

variable "bootdiag_storage_account_rg_name" {
  type        = string
  description = "Name of the Storage Account"
}

variable "secret_key_vault_name" {
  type = string
  description = "The password will be retrieved from the key vault."
}

variable "secret_key_vault_rg_name" {
  type = string
  description = "The password will be retrieved from the key vault resource group."
}

variable "sqlaoa-2node-primary-vm-DC10ANS01TFCW" {
  type = any
  description = "Configuration for the first SC node for two Node cluster"
}

variable "sqlaoa-2node-secondary-vm-DC10ANS01TFCW" {
  type = any
  description = "Configuration for the second SC node for two Node cluster"
}
