terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.7.0"
    }
  }

  backend "azurerm" {
    backendAzureRmSubscriptionId       = "795783af-96d3-4629-9161-58de5577ed1e"
    backendAzureRmResourceGroupName    = "pravith-vm-jump-box"
    backendAzureRmStorageAccountName   = "tfstatemsdn"
    backendAzureRmContainerName        = "tfstate"
    backendAzureRmKey                  = "statefile-fortrea.tfstate"
    backendServiceArm                  = "SC_CCS_400847_Priya_MSDN-2"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  // alias           = "integ-nprod-001"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}