module "resource_group" {
  providers                           =  {azurerm = azurerm.integ-nprod-001}
  source                              = "../modules/resource-group"
  resource_group_name                 = local.resource_group_name
  location                            = var.location
}

module "azurerm_key_vault" {  
  providers                         =  {azurerm = azurerm.integ-nprod-001}
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
module "private_endpoint_key_vault" {  
  providers                         =  {azurerm = azurerm.integ-mgmt-001}
  source                            = "../modules/private-endpoint"
  private_endpoint_name             = "pe-${local.key_vault_name}"
  location                          = var.location
  resource_group_name               = local.resource_group_name
  subnet_id                         = data.azurerm_subnet.default_subnet.id
  private_service_connection_name   = "${local.key_vault_name}-psc"
  private_connection_resource_id    = module.azurerm_key_vault.key_vault_id
  subresource_names                 = ["vault"]
  is_manual_connection              = false
  private_dns_zone_group_name       = "private-dns-zone-group"
  private_dns_zone_ids              = [data.azurerm_private_dns_zone.key_vault_dns.id]
  depends_on                        = [module.azurerm_key_vault]
}
