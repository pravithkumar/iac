module "networking" {
  providers            =  {azurerm = azurerm.integ-nprod-001}
  source              = "../modules/networking"  # Adjust path as needed
  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnets             = var.subnets
}
