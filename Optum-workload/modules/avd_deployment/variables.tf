
variable "existing_resource_group_name" {
  description = "The name of the existing Resource Group."
  type        = string
  default     = "optum-chinmayee" 
}

variable "existing_virtual_network_name" {
  description = "The name of the existing Virtual Network."
  type        = string
  default     = "chinmayeevnet"
}

variable "existing_subnet_name" {
  description = "The name of the existing Subnet."
  type        = string
  default     = "chinmayeesubnet"
}

variable "location" {
  description = "location of your existing resources."
  type        = string
  default     = "East US" 
}

variable "existing_nsg" {
  description = "Existing NSG."
  type        = string
  default     = "chinmayee-nsg"
}

variable "workspace_name" {
  description = "Name of AVD workspace"
  type        = string
  default     = "avd-workspace"
}

variable "host_pool_name" {
  description   = "Host pool name"
  type          = string
  default       = "avd-hostpool"
}
variable "host_pool_type" {
  description   = "Host pool type"
  type          = string
  default       = "Pooled"
}
variable "load_balancer_type" {
  description   = "Load Balancer Type"
  type          = string
  default       = "BreadthFirst"
}
variable "max_session_hosts" {
  description   = "Maximum session hosts allowed"
  type          = number
  default       = 3 
}
variable "application_group_name" {
  description     = "Name of application group name"
  type            = string
  default         = "avd-desktop-application-group-name"
}
variable "session_host_vm_name" {
  description     = "Name of Session Host VM"
  type            = string
  default         = "avd-sessionhost"
}
variable "vm_size"{
  description    = "Size of session host VM"
  type           = string
  default        = "Standard_D2a_v4"
}
variable "admin_username" {
  description   = "Username for session host VMs"
  type          = string
  default       = "Admin"
}









