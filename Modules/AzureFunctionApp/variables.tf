# variables.tf

variable "function_app_name" {
  type        = string
  description = "The name of the function app."
}

variable "location" {
  type        = string
  description = "The Azure region where the function app should be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the function app."
}

variable "app_service_plan_id" {
  type        = string
  description = "The ID of the App Service Plan."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
}

variable "storage_account_resource_group_name" {
  type        = string
  description = "The name of the resource group where storage account is located."
}

variable "app_insights_name" {
  type        = string
  description = "The name of the Application Insights instance."
}

variable "app_insights_resource_group_name" {
  type        = string
  description = "The name of the resource group where application insights is located."
}

variable "runtime" {
  type        = string
  description = "The runtime stack of the function app (e.g., dotnet, node, python, java, powershell, custom)."
  default     = "dotnet"
  validation {
    condition     = contains(["dotnet", "node", "python", "java", "powershell", "custom"], self)
    error_message = "Valid values for runtime are: dotnet, node, python, java, powershell, custom."
  }
}

variable "runtime_version" {
  type        = string
  description = "The version of the runtime stack (e.g., ~4, 16, 3.9)."
  default     = "~4"
}

variable "https_only" {
  type        = bool
  description = "Whether to enable HTTPS only."
  default     = true
}

variable "always_on" {
  type        = bool
  description = "Whether to enable Always On."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  default     = {}
}

variable "private_endpoint_subnet_id" {
  type        = string
  description = "The ID of the subnet to deploy the private endpoint into."
}

variable "private_dns_zone_id" {
  type        = string
  description = "The ID of the existing private DNS zone."
}