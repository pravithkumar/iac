variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the resources will be created"
  type        = string
}

variable "app_service_plan_sku_tier" {
  description = "The SKU tier for the App Service Plan"
  type        = string
}

variable "app_service_plan_sku_size" {
  description = "The SKU size for the App Service Plan"
  type        = string
}

variable "ase_id" {
  description = "The ID of the App Service Environment"
  type        = string
}

variable "logic_app_name" {
  description = "The name of the Logic App"
  type        = string
}