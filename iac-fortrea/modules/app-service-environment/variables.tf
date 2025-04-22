variable "ase_name" {
  description = "The name of the App Service Environment"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "internal_load_balancing_mode" {
  description = "The internal load balancing mode"
  type        = string
}


variable "cluster_settings" {
  description = "List of cluster settings"
  type        = list(object({
    name  = string
    value = string
  }))
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    env         = "production"
    terraformed = "true"
  }
}