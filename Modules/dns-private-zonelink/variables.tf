variable "dns_zone_id" {
  description = "The ID of the existing DNS Private Zone"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_link_name" {
  description = "The name of the virtual network link"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network"
  type        = string
}