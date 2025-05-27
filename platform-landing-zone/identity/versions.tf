# Configure Terraform to set the required AzureRM provider
# version and features{} block.

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.107"
    }
  }
  backend "azurerm" {
     subscription_id = "795783af-96d3-4629-9161-58de5577ed1e" 
   }  
  } 

provider "azurerm" {
  features {}
subscription_id  = var.identity_subscription_id 
}