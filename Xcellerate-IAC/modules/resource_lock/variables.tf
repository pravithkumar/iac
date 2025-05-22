variable "lock" {
  type = object({
    name = optional(string, null)
    kind = optional(string, "None")
  })
  description = "The lock level to apply to the ddos protection plan. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`."
  default = {
    name = "ProtectedResource"
    kind = "CanNotDelete"
  }
  nullable = false

}
variable "resourceScope" {
  description = "define the scope of the resource by providing the resource ID"
}
variable "name" {
  type        = string
  description = "the name of the ddos protection plan"
  validation {
    condition     = can(regex("^[a-z0-9-]{3,24}$", var.name))
    error_message = "The name must be between 3 and 24 characters long and can only contain lowercase letters, numbers and dashes."
  }
}
