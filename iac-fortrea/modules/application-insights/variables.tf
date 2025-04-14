variable "appinsights_name" {
  description = "The name of the Application Insights resource."
  type        = string
}

variable "location" {
  description = "The Azure region where the Application Insights resource will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Application Insights resource."
  type        = string
}

variable "law_workspace_id" {
  description = "The ID of the Log Analytics Workspace where the Application Insights data will be stored."
  type        = string
  default     = null
}

variable "application_type" {
  description = "The type of Application Insights resource. Possible values are 'web', 'java', 'other', 'mobilecenter'."
  type        = string
  default     = "web"
}

variable "retention_in_days" {
  description = "(Optional) Specifies the retention period in days. Must be between 30 and 730."
  type        = number
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}