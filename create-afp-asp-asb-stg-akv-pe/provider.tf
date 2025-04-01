terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.7.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "01f80ea1-e021-4e3c-ad77-3a7e68205304"
    resource_group_name  = "rg-tf-eastus-001"
    storage_account_name = "satfeastus001"
    container_name       = "devterraformstate"
    key                  = "adsprint_dev.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias           = "aiml-nprod-001"
  subscription_id = "7e4d6667-b8f3-4131-a847-447bc1ac93d1"
  features {}
}