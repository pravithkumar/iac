variable "settings" {
  description = "key vault certificate configuration"

  type = object({
    name                                         = string
    key_vault_id                                 = string
    
    certificate = optional(object({
      contents         = string
      password = string
    }))


  })
}