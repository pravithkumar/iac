variable "key_vault_id" {
  description = "The ID of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID"
  type        = string
}

variable "object_id" {
  description = "The object ID of the principal"
  type        = string
}

variable "secret_permissions" {
  description = "List of secret permissions"
  type        = list(string)
  default     = ["get", "list"]
}
