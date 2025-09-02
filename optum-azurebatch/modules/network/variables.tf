variable "location" {}
variable "resource_group_name" {}
variable "vnet_name" {}
variable "address_space" {}
variable "subnet_name" {}
variable "subnet_prefix" {
  type = list(string)
  default = ["10.0.1.0/24"]
}
