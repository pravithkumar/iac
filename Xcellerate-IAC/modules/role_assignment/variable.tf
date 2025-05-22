variable "settings" {
  description = "Role assignments configuration"
  type = object({
    name                 = optional(string)
    scope                = string
    role_definition_name = string
    principal_id         = string
  })
}