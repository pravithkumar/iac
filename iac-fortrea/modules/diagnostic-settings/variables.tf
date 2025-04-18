variable "enable_monitoring" {
  description = "Enable or disable monitoring"
  type        = bool
  default     = false
}

variable "monitor_diagnostic_name" {
  description = "Name of the diagnostic setting"
  type        = string
}

variable "target_resource_id" {
  description = "The ID of the resource to monitor"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace"
  type        = string
}

variable "category" {
  description = "The name of a Diagnostic Log Category for the Resource."
  type        = string
}

variable "log_categories" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = ["FunctionAppLogs", "AppServicePlatformLogs", "AuditLogs"]
}

