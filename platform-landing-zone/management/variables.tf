# Use variables to customize the deployment
variable "root_id" {
  type    = string
  default = "ES"
}

variable "management_subscription_id" {
    type    = string
    default = "795783af-96d3-4629-9161-58de5577ed1e"
}

variable "management_resources_location" {
  type    = string
  default = "eastus2"
}

variable "deploy_management_resources" {
  type    = bool
  default = true
}

variable "log_retention_in_days" {
  type    = number
  default = 50
}

variable "security_alerts_email_address" {
  type    = string
  default = "my_valid_security_contact@replace_me" # Replace this value with your own email address.
}

variable "management_resources_tags" {
  type = map(string)
  default = {
     Department = "IT"
     Owner = "Jane Doe"    
  }
}