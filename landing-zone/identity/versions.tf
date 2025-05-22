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
  }  
}

provider "azurerm" {
  features {}
subscription_id  = var.identity_subscription_id 
}