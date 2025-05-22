#resource group variables
variable "rg1_resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "rg1_location" {
  description = "The location of the resource group"
  type        = string
}

variable "rg1_subscription_id" {
  description = "The subscription id of the resource group"
  type        = string
}

variable "rg2_resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "rg2_location" {
  description = "The location of the resource group"
  type        = string
}

variable "rg2_subscription_id" {
  description = "The subscription id of the resource group"
  type        = string
}

variable "rg3_resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "rg3_location" {
  description = "The location of the resource group"
  type        = string
}

variable "rg3_subscription_id" {
  description = "The subscription id of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resource groups"
  type        = map(string)
  default     = {}
}

#vnet variables
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

#user managed identity variables
variable "name" {
  description = "The name of the managed identity"
  type        = string
}

variable "location" {
  type        = string
  description = "(Optional) The location/region to keep all your resources."
  default     = ""
}

variable "environment" {
  type        = string
  description = "Name of the Environment"
}
variable "app_name" {
  type        = string
  description = "Name of the App"
}

#mssql variable
variable "mssql_db_name" {
  type = string
  description = "Name of the MSSQL database"
}

#app gateway variable
variable "backend_address_fqdns" {
  description = "The names of the Backend address pool fqdn"
  type        = list(string)
}









