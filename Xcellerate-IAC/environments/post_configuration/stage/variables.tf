variable "location" {
  type        = string
  description = "(Optional) The location/region to keep all your resources."
  default     = ""
}
variable "environment" {
  type        = string
  description = "Name of the Environment"
}
variable "app_name" {
  type        = string
  description = "Name of the App"
}

variable "CERT_APPGW" {
  type        = string
  description = "Content of the Certificate"
}

variable "CERT_PASSWORD" {
  type        = string
  sensitive = true
  description = "Certificate Password"
}

















