variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "address_space" {
  type = list(string)
}
variable "subnets" {
  type = list(object({
    subnet_name      = string
    subnet_prefix = list(string)
    nsg_id           = optional(string)
    route_table_id   = optional(string)
        delegations = optional(list(object({
      name          = string
      service_name  = string
      actions       = list(string)
    })))
  }))
}
