variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, prod)"
  type        = string
}

variable "location_test" {
  description = "The Azure region (e.g., eastus, westus)"
  type        = string
}



