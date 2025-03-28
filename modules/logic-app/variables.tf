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

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
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

variable "user_assigned_identity_name" {
  description = "The name of the user-assigned managed identity."
  type        = string
}