terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Or a newer version like "~> 3.70"
    }
  }
}

provider "azurerm" {
  features {}
}