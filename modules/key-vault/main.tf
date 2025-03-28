provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "key_vault" {
  name                            = var.key_vault_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  sku_name                        = var.kvskuname
  purge_protection_enabled        = var.kvpurge_protection_enabled
  enable_rbac_authorization       = var.kvrbac_authorization
  public_network_access_enabled   = false
  soft_delete_retention_days      = var.kvsoft_delete_retention_days
  enabled_for_deployment          = var.enabledfordeployment 
  enabled_for_disk_encryption     = var.enabledfordiskencryption
  enabled_for_template_deployment = var.enabledfortemplatedeployment

  network_acls {
    default_action = var.kvnetdefaultaction
    bypass         = var.kvnetaclbypass

    ip_rules = var.kvip_rules

   
  }

  timeouts {
    create = var.kvtimeoutcreate
    update = var.kvtimeoutupdate
    delete = var.kvtimeoutdelete
  }

  tags = var.tags
}