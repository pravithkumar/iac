resource "azurerm_key_vault_certificate" "kv_certificate" {
  name         = var.settings.name
  key_vault_id = var.settings.key_vault_id

  certificate {
    contents = var.settings.certificate.contents
    password = var.settings.certificate.password
  }
}

