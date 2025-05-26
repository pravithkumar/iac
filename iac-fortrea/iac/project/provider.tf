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
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}

provider "azurerm" {
  alias           = "dmz"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}

provider "azurerm" {
  alias           = "mgmt"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}

provider "azurerm" {
  alias           = "shared-dns"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}