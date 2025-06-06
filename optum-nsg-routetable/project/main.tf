locals {
  nsgs = {
    "web-nsg" = {
      name     = "web-nsg"
      location = var.location
      rules = [
        {
          name                       = "AllowHTTP"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "*"
          destination_address_prefix = "*"
        }
      ]
    },
    "ssh-nsg" = {
      name     = "ssh-nsg"
      location = var.location
      rules = [
        {
          name                       = "AllowSSH"
          priority                   = 200
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
  }
}

module "nsgs" {
  for_each            = local.nsgs
  source              = "./modules/nsg"
  name                = each.value.name
  location            = each.value.location
  resource_group_name = var.resource_group_name
  security_rules      = each.value.rules
}
