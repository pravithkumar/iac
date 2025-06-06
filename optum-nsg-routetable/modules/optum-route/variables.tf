variable "name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "disable_bgp_route_propagation" { type = bool default = false }
variable "tags" { type = map(string) default = {} }

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = null
}
