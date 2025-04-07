variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
}
variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}