# Use variables to customize the deployment
variable "root_id" {
  type    = string
  default = "ES"
}

variable "deploy_connectivity_resources" {
  type    = bool
  default = true
}

variable "connectivity_resources_location" {
  type    = string
  default = "eastus2"
}

variable "connectivity_subscription_id" {
    type    = string
    default = "ef1ee86b-4147-4f18-a1b0-08f64bcc72be"
}

variable "connectivity_resources_tags" {
  type = map(string)
  default = {
     Department = "IT"
     Owner = "Jane Doe"       
  }
}

#######################################end###########################
#additional customize variables:

variable "virtual_network_gateway_enable" {
  description = "Enable or disable the virtual network gateway"
  type        = bool
  default     = false
}

variable "expressroute_gateway_sku" {
  description = "select virtual network gateway sku type"  
  type        = string
  default     = "Standard"  
}

variable "vpn_gateway_sku" {
  description = "select virtual network gateway sku type"
  type        = string 
  default     = "VpnGw2"
}


variable "azure_firewall_enable" {
  description = "Enable or disable the azure firewall"
  type        = bool
  default     = false
}

variable "azure_firewall_sku_tier" {
  description = "select azure firewall sku tier"
  type        = string
  default     = "Standard"
}

variable "dns_zone_enable" {
  description = "Enable or disable the dns zone"
  type        = bool
  default     = false
}

variable "ddos_protection_plan_enable" {
  description = "Enable or disable the ddos protection plan"
  type        = bool
  default     = false
}

variable "ddos_protection_plan_link" {
  description = "attach or deattach ddos protection plan"
  type        = bool
  default     = false
}

variable "deployment_location" {
  description = "select resources primary deployment location"
  type        = string
  default     = "eastus2"  
}

#######################################end###########################
#Local Network Gateway Variables

variable "deploy_local_network_gateway" {
  description = "Enable or disable the local network gateway"
  type        = bool
  default     = false
}

variable "tags" {
  type = map(string)
  default = {
     Department = "IT"
     Owner = "Jane Doe"       
  }
}

########################################################################
#VPN Connection detail

// variable "vpnConnections" {
//   type = list(object({
//     vpn_connection_name                = string
//     vpn_location                       = string
//     resource_group_name                = string
//     virtual_network_gateway_id         = string
//     local_network_gateway_id           = string
//     vpn_type                           = string
//     vpn_connection_protocol            = string
//     vpn_shared_key                     = string
//     enable_bgp                         = bool
//     use_policy_based_traffic_selectors = bool
//   }))
// }