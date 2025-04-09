terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.7.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "795783af-96d3-4629-9161-58de5577ed1e"  
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias           = "integ-nprod-001"
  subscription_id = "c6806c08-6845-4be9-bda8-0d35ff0251eb"
  features {}
}

provider "azurerm" {
  alias           = "integ-mgmt-001"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}