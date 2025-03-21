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

variable "private_endpoint_subnet_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

# variables.tf

variable "service_plan_name" {
  type        = string
  description = "The name of the Azure App Service Plan."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the App Service Plan will be created."
}




variable "os_type" {
  type        = string
  description = "The operating system type for the App Service Plan (e.g., Linux, Windows)."
}

variable "aspsku_name" {
  type        = string
  description = "The SKU name for the App Service Plan (e.g., B1, S1, P1v2)."
}

variable "worker_count" {
  type        = number
  description = "The number of workers (instances) to allocate for the App Service Plan."
  default     = 1
}

