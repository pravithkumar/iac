# General Variables
variable "location" {
  description = "The location/region where resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for deployment."
  type        = string
}

# Function App Specific Variables
variable "function_app_name" {
  description = "The name of the Azure Function App."
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan for the Function App."
  type        = string
}

variable "runtime" {
  description = "The runtime stack for the Azure Function App (e.g., 'node', 'dotnet')."
  type        = string
}

variable "runtime_version" {
  description = "The runtime version for the Azure Function App."
  type        = string
}

variable "https_only" {
  description = "Specifies if the Function App should enforce HTTPS connections only."
  type        = bool
}

variable "always_on" {
  description = "Specifies if the Function App should have the Always On setting enabled."
  type        = bool
}

# Storage Account Variables
variable "storage_account_name" {
  description = "The name of the Storage Account used by the Function App."
  type        = string
}

variable "storage_account_resource_group_name" {
  description = "The resource group of the Storage Account."
  type        = string
}

# Application Insights Variables
variable "app_insights_name" {
  description = "The name of the Application Insights instance."
  type        = string
}

variable "app_insights_resource_group_name" {
  description = "The resource group of the Application Insights instance."
  type        = string
}

# Networking Variables
variable "private_endpoint_subnet_id" {
  description = "The ID of the subnet where the private endpoint will be created."
  type        = string
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone to associate with the private endpoint."
  type        = string
}

variable "function_app_private_dns_zone_name" {
  description = "The name of the private DNS zone for the Function App."
  type        = string
}

# Virtual Network Variables
variable "existing_vnet_name" {
  description = "The name of the existing Virtual Network."
  type        = string
}

variable "rg_for_vnet" {
  description = "The resource group name of the existing Virtual Network."
  type        = string
}

# Tags
variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
}
