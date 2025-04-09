# variables.tf

variable "function_app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_service_plan_name" { 
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

variable "identity_type" {
  description = "The type of identity to assign to the resource. Possible values are 'SystemAssigned' or 'UserAssigned'."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "The list of user-assigned identity IDs to assign to the resource. Only used if identity_type is 'UserAssigned'."
  type        = list(string)
  default     = []
}

