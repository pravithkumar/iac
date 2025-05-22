# variables.tf

variable "service_plan_name" {
  type        = string
  description = "The name of the Azure App Service Plan."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the App Service Plan will be created."
}

variable "location" {
  type        = string
  description = "The Azure region where the App Service Plan will be created."
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to apply to the App Service Plan."
  default     = {}
}

variable "ase_resource_group_name" {
  description = "The resource group name of the existing App Service Environment"
  type        = string
}

variable "ase_name" {
  description = "The name of the existing App Service Environment"
  type        = string
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
