
variable "resource_group_name" {
  description = "The name of the resource group "
  type        = string
  default     = ""
}

variable "location" {
  description = "The name of the location "
  type        = string
  default     = "US"
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
