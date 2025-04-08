variable "api_management_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "publisher_name" {
  type = string
}

variable "publisher_email" {
  type = string
}

variable "sku" {
  type = string
}

variable "sku_count" {
  type = string
}

variable "tags" {
  type = map(string)
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