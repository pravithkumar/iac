variable "keyvault_name" {
  description = "The name of the existing Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group containing the Key Vault"
  type        = string
}
variable "location_test" {
  type        = string
  description = "Location for testing"
  default     = "eastus"
}
