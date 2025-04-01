terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.7.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "795783af-96d3-4629-9161-58de5577ed1e"
    resource_group_name  = "pravith-vm-jump-box"
    storage_account_name = "tfstatemsdn"
    container_name       = "tfstate"
    key                  = "statefile-fortrea.tfstate"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias           = "aiml-nprod-001"
  subscription_id = "7e4d6667-b8f3-4131-a847-447bc1ac93d1"
  features {}
}