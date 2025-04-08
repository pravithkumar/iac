
module "azurerm_key_vault" {  
  providers                         =  { azurerm = azurerm.integ-nprod-001 }
  source                            = "../modules/key-vault"
  azurerm_key_vault_name            = local.key_vault_name
  resource_group_name               = local.resource_group_name
  location                          = var.location  
  enabled_for_disk_encryption       = true
  soft_delete_retention_days        = 7
  purge_protection_enabled          = true
  sku_name                          = "standard"
  enabled_for_template_deployment   = true
  enabled_for_deployment            = true
  enable_rbac_authorization         = true
  public_network_access_enabled     = false
  network_acls                      = []
  tags                              = var.tags
 
}

resource "azurerm_private_endpoint" "example" {
  provider            = azurerm.integ-nprod-001
  name                = "pe-${local.key_vault_name}"
  location            = var.location
  resource_group_name = "local.resource_group_name"
  subnet_id           = data.azurerm_subnet.default_subnet.id
  private_service_connection {
    name                           = "exampleConnection"
    private_connection_resource_id = azurerm_key_vault.example.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
  private_dns_zone_group {
    name                 = "privatelink.vaultcore.azure.net"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.key_vault_dns.id]
  }
}


