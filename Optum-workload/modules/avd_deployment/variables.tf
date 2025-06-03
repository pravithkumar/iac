
variable "resource_group_name" {
  description = "The name of the resource group "
  type        = string
  default     = ""
}

variable "location" {
  description = "The name of the location "
  type        = string
  default     = "US"
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network."
  type        = string
  default     = "avd-vnet"
}

variable "address_space"{
  description   = "Address space of VNet"
  type          = string
  default     = "10.0.0.0/16"
}

variable "subnet_address_prefix" {
  description = "The address prefix for the Subnet."
  type        = string
  default     = "10.0.0.0/32"
}


