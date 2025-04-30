terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.7.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "01f80ea1-e021-4e3c-ad77-3a7e68205304" 
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias           = "integ-nprod-001"
  subscription_id = "6a188292-2123-478e-aea7-0876e0c388b9"
  features {}
}