provider "azurerm" {
  features {}
}

module "app_service_environment" {
  source                          = "../Modules/AppServiceEnvironment"
  ase_name                        = var.ase_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  subnet_id                       = var.subnet_id
  internal_load_balancing_mode    = var.internal_load_balancing_mode
  virtual_ip_type                 = var.virtual_ip_type
  physical_hardware_isolation     = var.physical_hardware_isolation
  zone_redundancy                 = var.zone_redundancy
  dns_settings                    = var.dns_settings
  inbound_ip_address              = var.inbound_ip_address
  cluster_settings                = var.cluster_settings
  tags                            = var.tags
}

