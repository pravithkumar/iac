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

variable "os_type" {
  description = "The operating system type for the App Service Plan (e.g., Windows, Linux)."
  type        = string
  default     = "Windows"
}

variable "sku_name" {
  description = "The SKU name for the App Service Plan (e.g., B1, P1v2)."
  type        = string
}
variable "enable_app_insights" {
  type        = bool
  description = "Whether to enable Application Insights integration for the Function App."
  default     = false
}

variable "appinsights_instrumentationkey" {
  type        = string
  description = "Instrumentation Key for Application Insights"
}

variable "applicationinsights_connectionstring" {
  type        = string
  description = "Connection String for Application Insights"
}

variable "app_settings" {
  type        = map(string)
  description = "A map of application settings to apply to the Function App."
  default     = {}
}

variable "https_only" {
  type        = bool
  description = "Should only HTTPS traffic be allowed to the Logic App?"
  default     = true
}

variable "min_tls_version" {
  type = string
}

variable "tags" {
  type = map(string)
}

