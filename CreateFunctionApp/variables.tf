# variables.tf

variable "subscription_id" {
  type = string
  description = "The Azure subscription ID."
}

variable "tenant_id" {
  type = string
  description = "The Azure tenant ID."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group."
  default = "function-app-rg"
}

variable "location" {
  type = string
  description = "The Azure region to use."
  default = "East US"
}

variable "app_service_plan_name" {
  type = string
  description = "The name of the App Service Plan."
  default = "function-app-plan"
}

variable "app_service_plan_kind" {
  type = string
  description = "The kind of the App Service Plan."
  default = "FunctionApp"
}

variable "app_service_plan_reserved" {
  type = bool
  description = "Is reserved for Linux."
  default = true
}

variable "app_service_plan_tier" {
  type = string
  description = "The tier of the App Service Plan."
  default = "PremiumV3"
}

variable "app_service_plan_size" {
  type = string
  description = "The size of the App Service Plan."
  default = "P1v3"
}

variable "storage_account_name" {
  type = string
  description = "The name of the Storage Account."
  default = "functionappstorage"
}

variable "storage_account_tier" {
  type = string
  description = "The tier of the Storage Account."
  default = "Standard"
}

variable "storage_account_replication_type" {
  type = string
  description = "The replication type of the Storage Account."
  default = "LRS"
}

variable "application_insights_name" {
  type = string
  description = "The name of the Application Insights instance."
  default = "function-app-insights"
}

variable "application_insights_type" {
  type = string
  description = "The application type of the Application Insights instance."
  default = "function"
}

variable "function_app_name" {
  type = string
  description = "The name of the Function App."
  default = "function-app"
}

variable "function_app_version" {
  type = string
  description = "The runtime version of the Function App."
  default = "~4"
}

variable "function_app_https_only" {
  type = bool
  description = "Enforce HTTPS."
  default = true
}

variable "function_app_always_on" {
  type = bool
  description = "Enable Always On."
  default = true
}

variable "python_version" {
  type = string
  description = "The Python version."
  default = "3.9"
}

variable "allowed_origins" {
  type = list(string)
  description = "Allowed CORS origins."
  default = ["*"]
}

variable "function_worker_runtime" {
  type = string
  description = "The Function App worker runtime."
  default = "python"
}

variable "function_app_identity_type" {
  type = string
  description = "The type of identity for the function app"
  default = "SystemAssigned"
}