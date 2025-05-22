variable "key_vault_id" {
  description = "the id of of an keyvault where secret is being stored"
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

variable "password_validity_days" {
  description = "Number of days the password is valid for"
  type        = number
  default     = 90
}
