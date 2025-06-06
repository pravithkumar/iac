variable "existing_resource_group_name" {
  description = "The name of the existing Resource Group."
  type        = string
  default     = "optum-chinmayee" 
}

variable "existing_virtual_network_name" {
  description = "The name of the existing Virtual Network."
  type        = string
  default     = "chinmayeevnet"
}

variable "existing_subnet_name" {
  description = "The name of the existing Subnet."
  type        = string
  default     = "chinmayeesubnet"
}

variable "location" {
  description = "location of your existing resources."
  type        = string
  default     = "East US" 
}

variable "gallery_name" {
  description = "Name of the image gallery"
  type        = string
  default     = "avd-gallery01"
}
variable "gallery_description" {
  description = "Description of the image gallery"
  type        = string
  default     = "Its a compute gallery for storing images"
}