variable "service_principal_id" {
  description = "The ID of the service principal"
  type        = string
}

variable "keyvault_name" {
  description = "The name of the existing Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group containing the Key Vault"
  type        = string
}
