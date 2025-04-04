variable "resource_groups" {
  description = "List of resource groups with their names"
  type = list(object({
    name = string
  })
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