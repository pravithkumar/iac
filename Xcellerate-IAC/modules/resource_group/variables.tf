variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to resource Group"
}
