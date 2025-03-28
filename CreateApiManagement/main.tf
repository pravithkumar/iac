provider "azurerm" {
  features {}  
}


module "api_management" {
  source                          = "../Modules/api-management"
  api_management_name             = var.api_management_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  publisher_name                  = var.publisher_name
  publisher_email                 = var.publisher_email
  sku                             = var.api_sku
  sku_count                       = var.sku_count
  tags                            = var.tags
}

module "private_endpoint_api_management" {
  source                          = "../Modules/private-endpoint"
  private_endpoint_name           = var.private_endpoints[0].name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  subnet_id                       = var.private_endpoints[0].subnet_id
  private_service_connection_name = "${var.api_management_name}-psc"
  private_connection_resource_id  = module.api_management.id
  subresource_names               = var.private_endpoints[0].subresource_names
  is_manual_connection            = false
  private_dns_zone_group_name     = "private-dns-zone-group"
  private_dns_zone_ids            = var.private_endpoints[0].private_dns_zone_ids
  depends_on                      = [module.api_management]
}