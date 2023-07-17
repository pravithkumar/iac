
data "azurerm_resource_group" "storagerg" {
  name     = var.resource_group_name
}

data "azurerm_storage_account" "sa" {
  name                = var.storageAccountName
  resource_group_name = var.resource_group_name
}

resource "azurerm_storage_account_network_rules" "rules" {
  storage_account_id = data.azurerm_storage_account.sa.id

  default_action             = var.defalutaction  
  virtual_network_subnet_ids = var.subnetid
 
}