variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_id" {
  description = "The name of the existing VNet"
  type        = string
}

variable "dns_zones" {
  description = "Map of DNS zone names with their corresponding link names"
  type        = map(string)
}