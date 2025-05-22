variable "identity_name" {
  description = "The name of the managed identity"
  type        = string
}

variable "location" {
  type        = string
  description = "Region for the infrastructure deployment"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the Resource Group"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to resource Group"
}