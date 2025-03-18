terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Or the latest version (e.g., "~> 3.70")
    }
  }
}

provider "azurerm" {
  features {}
}