variable "resource_groups" {
  description = "List of resource groups with their names"
  type = list(object({
    name = string
  }))
}

variable "location" {
  description = "The location for the resource groups"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnets to create"
  type        = list(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "private_dns_zones" {
  description = "A list of private DNS zones to create"
  type        = list(object({
    name = string
  }))
}

variable "appinsights" {
  description = "Application Insights configuration"
  type = object({
    name                 = string
    resource_group_name  = string
    application_type     = string
    retention_in_days   = optional(number)
  })
}

variable "loganalytics" {
  description = "Log Analytics workspace configuration"
  type = object({
    name                 = string
    resource_group_name  = string
    sku                  = string
    retention_in_days    = optional(number)
    identity             = object({
      type         = string
      identity_ids = list(string)
    })
})
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}