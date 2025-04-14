variable "law_name" {
  description = "The name of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "The location for the Log Analytics workspace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group that the Log Analytics workspace will be placed in"
  type        = string
}

variable "sku" {
  description = "The SKU for the Log Analytics workspace"
  type        = string
  default     = "PerGB2018"  # You can specify a default SKU if desired
}

variable "retention_in_days" {
  description = "The retention period for data in the Log Analytics workspace (in days)"
  type        = number
  default     = null  # This is optional, defaulting to null if not provided
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

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}