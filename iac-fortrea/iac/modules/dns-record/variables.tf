variable "record_name" {
  description = "The name of the A record to create (e.g., function app or logic app name)."
  type        = string
}

variable "zone_name" {
  description = "The name of the existing private DNS zone"
  type        = string
}

variable "dns_zone_resource_group" {
  description = "The name of the resource group where the private DNS zone is located."
  type        = string
}

variable "ttl" {
  description = "Time to live (TTL) for the DNS record in seconds."
  type        = number
  default     = 300
}

variable "ip_addresses" {
  description = "List of IP addresses to associate with the A record"
  type        = list(string)
}
