# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

module "aks" {
  source                 = "../Modules/aks"
  resource_group_name    = var.resource_group_name
  Vnet_resource_group_name    = var.Vnet_resource_group_name
  aksname                = var.aksname
  dnsprefix              = var.dnsprefix
  nodepoolname           = var.nodepoolname
  nodecount              = var.nodecount
  vmsize                 = var.vmsize
  osdisksize             = var.osdisksize
  autoscale              = var.autoscale
  maxpods                = var.maxpods
  maxcount               = var.maxcount
  mincount               = var.mincount
  subnetid               = var.subnetid   
  private_dns_zone_id    = var.private_dns_zone_id 
    EnableMSDefender      = var.EnableMSDefender
  MSDefenderLAID        = var.MSDefenderLAID
}