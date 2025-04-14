variable "scope" {
  type        = string
  description = "The scope at which the Role Assignment should be created. This could be a Subscription ID, a Resource Group ID, or a Resource ID."
}

variable "role_definition_name" {
  type        = string
  description = "The name of the Role Definition to assign. Examples include 'Reader', 'Contributor', 'Owner', or a custom role name."
}

variable "principal_id" {
  type        = string
  description = "The Object ID of the Principal (User, Group, or Service Principal) to which the Role Definition should be assigned."
}