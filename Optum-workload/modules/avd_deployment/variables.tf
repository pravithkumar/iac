provider "azurerm" {
  
}

variable "existing_resource_group_name" {
  description = "The name of the existing Resource Group."
  type        = string
  default     = "optum-chinmayee" 
}

variable "existing_virtual_network_name" {
  description = "The name of the existing Virtual Network."
  type        = string
  default     = "chinmayeevnet"
}

variable "existing_subnet_name" {
  description = "The name of the existing Subnet."
  type        = string
  default     = "chinmayeesubnet"
}

variable "location" {
  description = "location of your existing resources."
  type        = string
  default     = "East US" 
}