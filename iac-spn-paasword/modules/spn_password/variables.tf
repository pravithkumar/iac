variable "keyvault_name" {
  description = "The name of the existing Key Vault"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group containing the Key Vault"
  type        = string
}
variable "app_password_display_name" {
  type        = string
  description = "application password display name" 
}

variable "app_kv_secret_name" {
  type        = string
  description = "application keyvault secret name" 
}

variable "spn_name" {
  type        = string
  description = "SPN name" 
}
