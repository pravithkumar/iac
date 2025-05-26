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
    default = "94876ed9-b91b-4357-ab64-b0080e493e82"
}

variable "connectivity_subscription_id" {
    type    = string
    default = "ef1ee86b-4147-4f18-a1b0-08f64bcc72be"
}

variable "management_subscription_id" {
    type    = string
    default = "c9980f13-e913-4a6e-89d9-703107b8ec4c"
}

#--------------------------end-------------------------------
# Use variables for subscription enrollment

variable "identity_subscription_ids" {
    type    = list
    default = ["94876ed9-b91b-4357-ab64-b0080e493e82"]
}

variable "connectivity_subscription_ids" {
    type    = list
    default = ["ef1ee86b-4147-4f18-a1b0-08f64bcc72be"]
}

variable "management_subscription_ids" {
    type    = list
    default = ["c9980f13-e913-4a6e-89d9-703107b8ec4c"]
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