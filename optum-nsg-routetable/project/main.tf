module "nsg" {
  source              = "./modules/nsg"
  name                = "example-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  security_rules = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

module "route_table" {
  source              = "./modules/route_table"
  name                = "example-rt"
  location            = var.location
  resource_group_name = var.resource_group_name
  routes = [
    {
      name           = "default-route"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}
