# Modules/AzureFunctionApp/variables.tf

variable "function_app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_service_plan_id" {
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
  type = string # Corrected this line
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