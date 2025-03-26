provider "azurerm" {
  features {}
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "example-resources"
}

variable "location" {
  description = "The location of the resources"
  type        = string
  default     = "East US"
}

variable "ase_name" {
  description = "The name of the existing App Service Environment"
  type        = string
}

variable "ase_resource_group_name" {
  description = "The resource group name of the existing App Service Environment"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "examplestorageacct"
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "example-asp"
}

variable "logic_app_name" {
  description = "The name of the Logic App Standard"
  type        = string
  default     = "example-logicapp"
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

# Reference to the existing ASE
data "azurerm_app_service_environment_v3" "existing" {
  name                = var.ase_name
  resource_group_name = var.ase_resource_group_name
}

resource "azurerm_storage_account" "example" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "ASEV3"
  reserved            = true

  sku {
    tier = "PremiumV3"
    size = "P1v3"
  }

  app_service_environment_id = data.azurerm_app_service_environment_v3.existing.id
}

resource "azurerm_logic_app_standard" "example" {
  name                = var.logic_app_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  storage_account {
    name = azurerm_storage_account.example.name
  }
}