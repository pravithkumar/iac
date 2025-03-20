variable "location" {
  type        = string
  description = "resource location"
  default     = "eastus"
}

variable "resource_group_name" {
  type = string
}
variable "existing_vnet_name" {
  type = string
}


variable "subnet_id" {
  type = string
}

variable "acr_name" {
  type = string
}
variable "aks_acr_private_dns_name" {
  type = string
}
variable "private_connection_resource_id" {
  type = string
}

variable "rg_for_vnet" {
  type = string
}
#rg_for_vnet

