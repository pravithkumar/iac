# Use variables to customize the deployment
variable "root_id" {
  type    = string
  default = "ES"
}

variable "root_name" {
  type    = string
  default = "Enterprise Scale"
}

variable "identity_resources_location" {
  type    = string
  default = "eastus2"
}

variable "primary_location" {
  type    = string
  default = "eastus2"    
}

variable "secondary_location" {
  type    = string
  default = "centralus"    
}

variable "deploy_identity_resources" {
  type    = bool
  default = true
}

variable "identity_subscription_id" {
    type    = string
    default = "795783af-96d3-4629-9161-58de5577ed1e"
}

variable "connectivity_subscription_id" {
    type    = string
    default = "795783af-96d3-4629-9161-58de5577ed1e"
}

variable "management_subscription_id" {
    type    = string
    default = "795783af-96d3-4629-9161-58de5577ed1e"
}

#--------------------------end-------------------------------
# Use variables for subscription enrollment

variable "identity_subscription_ids" {
    type    = list
    default = ["795783af-96d3-4629-9161-58de5577ed1e"]
}

variable "connectivity_subscription_ids" {
    type    = list
    default = ["795783af-96d3-4629-9161-58de5577ed1e"]
}

variable "management_subscription_ids" {
    type    = list
    default = ["795783af-96d3-4629-9161-58de5577ed1e"]
}

variable "corp-us-eus_subscription_ids" {
    type    = list
    default = ["aeb6e090-4331-4f7b-9a1a-5212bce13c99"]
}

variable "corp-us-cus_subscription_ids" {
    type    = list
    default = [""]
}

variable "Sandbox_subscription_ids" {
    type    = list
    default = [""]
}