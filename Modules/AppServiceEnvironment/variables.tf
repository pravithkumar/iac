variable "ase_name" {
  description = "The name of the App Service Environment"
  type        = string
}

variable "location" {
  description = "The location of the resources"
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
  description = "The internal load balancing mode for the ASE"
  type        = string
}

variable "virtual_ip_type" {
  description = "The type of Virtual IP (internal or external)"
  type        = string
}

variable "physical_hardware_isolation" {
  description = "Physical hardware isolation setting (Enabled or Disabled)"
  type        = string
}

variable "zone_redundancy" {
  description = "Zone redundancy setting (Enabled or Disabled)"
  type        = string
}

variable "dns_settings" {
  description = "DNS settings (manual or automatic)"
  type        = string
}

variable "inbound_ip_address" {
  description = "Inbound IP address setting (automatic or manual)"
  type        = string
}

variable "cluster_settings" {
  description = "Cluster settings for the ASE"
  type        = list(object({
    name  = string
    value = string
  }))
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}