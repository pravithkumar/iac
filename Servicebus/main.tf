module "servicebus" {
  source              = "./modules/servicebus"
  resource_group_name = var.resource_group_name
  location            = var.location
  servicebus_name     = var.servicebus_name
  sku                 = var.servicebus_sku
  private_endpoints   = var.private_endpoints
}