#vnet for aks
data "azurerm_virtual_network" "existing_vnet" {
  name                = var.existing_vnet_name #vnet-xl-nonprod-eastus-001
  #resource_group_name = var.resource_group_name
  resource_group_name = var.rg_for_vnet 
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "${var.acr_name}-private-endpoint"
  location            =  var.location 
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id  

  private_service_connection {
    name                           = "${var.acr_name}-privatelink"
    private_connection_resource_id = var.private_connection_resource_id   #module.acr-mode.acr_id.id
    is_manual_connection           = false
    subresource_names              = ["registry"]  # To connect to the ACR registry service
  }
}
resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = var.aks_acr_private_dns_name 
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr_vnet_link" {
  name                  = "${var.acr_name}-dns-link"
  resource_group_name = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.acr_private_dns_zone.name
  virtual_network_id    =  data.azurerm_virtual_network.existing_vnet.id
}
resource "azurerm_private_dns_a_record" "acr_private_dns_record" {
  name                = var.acr_name # Use the ACR name for the DNS record
  zone_name           = azurerm_private_dns_zone.acr_private_dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.acr_private_endpoint.private_service_connection[0].private_ip_address]  
}
