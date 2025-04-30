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

