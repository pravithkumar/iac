variable "resource_group_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "location" {
  description = "The name of the virtual network"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resource groups"
  type        = map(string)
  default     = {}
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_prefixes" {
  description = "The address prefixes for the subnets"
  type        = list(string)
}

variable "subnet_names" {
  description = "The names of the subnets"
  type        = list(string)
}


