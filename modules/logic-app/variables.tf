variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "ase_name" {
  description = "The name of the existing App Service Environment"
  type        = string
}

variable "ase_resource_group_name" {
  description = "The resource group name of the existing App Service Environment"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the existing storage account"
  type        = string
}

variable "storage_resource_group_name" {
  description = "The resource group name of the existing storage account"
  type        = string
}

variable "app_service_plan_name_1" {
  description = "name of the service plan for logic app and app service environment"
  type        = string 
}

variable "logic_app_name" {
  description = "The name of the Logic App"
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key of the existing storage account"
  type        = string
}

variable "identity" {
  description = "Identity configuration for the resource"
  type = object({
    type        = string
    identity_ids = list(string)
  })
  default = {
    type        = "SystemAssigned"
    identity_ids = []
  }
}

variable "os_type" {
  description = "The operating system type for the App Service Plan (e.g., Windows, Linux)."
  type        = string
  default     = "Windows"
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan (e.g., B1, P1v2)."
  type        = string
}
