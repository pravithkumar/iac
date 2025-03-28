variable "resource_group_name" {
  type = string
}
variable "Vnet_resource_group_name" {
  type = string  
}

variable "aksname" {
  type = string
}

variable "dnsprefix" {
  type = string
}

variable "nodepoolname" {
  type = string
}

variable "nodecount" {
  type = string
}

variable "vmsize" {
  type = string
}

variable "osdisksize" {
  type = string
}

variable "maxpods" {
  type = string
}

variable "autoscale" {
  type = string
}

variable "maxcount" {
  type = string
}

variable "mincount" {
  type = string
}

variable "subnetid" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

variable "EnableMSDefender"{
    type = bool
    default = false
}

variable "MSDefenderLAID"{
    type = string
    default = null
}

