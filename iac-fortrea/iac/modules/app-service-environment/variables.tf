variable "ase_name" {
  description = "The name of the App Service Environment"
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
  description = "The internal load balancing mode"
  type        = string
}


variable "disable_tls1_0" {
  description = "Disable TLS 1.0 setting"
  type        = string
  default     = "1"
}

variable "internal_encryption" {
  description = "Internal encryption setting"
  type        = string
  default     = "true"
}

variable "frontend_ssl_cipher_suite_order" {
  description = "Front-end SSL cipher suite order"
  type        = string
  default     = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default = {
    env         = "production"
    terraformed = "true"
  }
}

variable "allow_new_private_endpoint_connections" {
  type        = bool
  description = "Specifies if the API Management service should allow new private endpoint connections."
  default     = true # Or false, depending on your desired default
}

variable "remote_debugging_enabled" {
  type        = bool
  description = "Specifies if remote debugging is enabled for the API Management service."
  default     = false # Or true, depending on your desired default
}