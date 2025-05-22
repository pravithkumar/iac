terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.20.0"
    }
  }

  backend "azurerm" {
    subscription_id = "01f80ea1-e021-4e3c-ad77-3a7e68205304"
  }
}

provider "azurerm" {
  alias           = "applz"
  subscription_id = "67f22aef-fb98-484d-b93a-fd24f9236c2c"
  features {}
}

provider "azurerm" {
  alias           = "dmz"
  subscription_id = "d5fbc7cc-9748-4dfd-9de6-4915eed83bd0"
  features {}
}

provider "azurerm" {
  alias           = "shared_services"
  subscription_id = "29d43faa-10c8-436c-849e-d0d9c1e03a6f"
  features {}
}

provider "azurerm" {
  alias           = "mgmt"
  subscription_id = "87bd9787-7ec0-451d-aa1e-aa20f168e3ed"
  features {}
}

provider "azurerm" {

  features {}
}



