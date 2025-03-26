variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
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
  description = "The name of the storage account"
  type        = string
  default     = "examplestorageacct"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "example-asp"
}

variable "logic_app_name" {
  description = "The name of the Logic App Standard"
  type        = string
  default     = "example-logicapp"
}