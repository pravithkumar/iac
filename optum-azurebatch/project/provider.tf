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
    key                  = "statefile-optum-lz1.tfstate"
    tenant_id             = "188285f7-8f1e-4c0d-a0bc-797e3e38c5b3"
  }
}

provider "azurerm" {
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}

provider "azurerm" {
  alias           = "integ-nprod-001"
  subscription_id = "795783af-96d3-4629-9161-58de5577ed1e"
  features {}
}
