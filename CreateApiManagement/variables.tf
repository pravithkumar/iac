variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "private_endpoints" {
  type = list(object({
    name                = string
    subnet_id           = string
    private_dns_zone_ids = list(string)
    subresource_names   = list(string)
  }))
}


variable "api_management_name" {
  type = string
}

variable "publisher_name" {
  type = string
}

variable "publisher_email" {
  type = string
}

variable "api_sku" {
  type = string
}

variable "sku_count" {
  type = string
}