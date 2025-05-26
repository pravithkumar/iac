locals {
  resource_group_name = "ES-connectivity-eastus2"
  location            = "East US 2"
  lgw_gateway_name    = "ES-elgw-eastus2"
  lgw_gateway_address = "10.0.0.1"
  lgw_address_space   = ["10.0.0.0/24"]
}