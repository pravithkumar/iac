terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.7.0"
    }
  }

  backend "azurerm" {
    subscription_id      = "6a188292-2123-478e-aea7-0876e0c388b9" 
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  alias           = "integ-nprod-001"
  subscription_id = "6a188292-2123-478e-aea7-0876e0c388b9"
  features {}
}

provider "azurerm" {
  alias           = "dmz"
  subscription_id = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"
  features {}
}

provider "azurerm" {
  alias           = "mgmt"
  subscription_id = "87bd9787-7ec0-451d-aa1e-aa20f168e3ed"
  features {}
}

provider "azurerm" {
  alias           = "shared-dns"
  subscription_id = "29d43faa-10c8-436c-849e-d0d9c1e03a6f"
  features {}
}