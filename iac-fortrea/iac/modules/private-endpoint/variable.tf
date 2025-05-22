# Modules/PrivateEndpoint/variables.tf

variable "private_endpoint_name" {
  description = "Name of the private endpoint"
  type        = string
}

variable "location" {
  description = "Location of the private endpoint"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name for the private endpoint"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
}

variable "private_service_connection_name" {
  description = "Name of the private service connection"
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID for the private connection"
  type        = string
}

variable "subresource_names" {
  description = "Subresource names for the private connection"
  type        = list(string)
}

variable "is_manual_connection" {
  description = "Indicates if the connection is manual"
  type        = bool
}

variable "private_dns_zone_group_name" {
  description = "Name of the private DNS zone group"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "IDs of the private DNS zones"
  type        = list(string)
}

variable "tags" {
  type = map(string)
}
