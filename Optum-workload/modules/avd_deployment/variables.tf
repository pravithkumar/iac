
variable "existing_resource_group_name" {
  description = "The name of the existing Resource Group."
  type        = string
}

variable "existing_virtual_network_name" {
  description = "The name of the existing Virtual Network."
  type        = string
}

variable "existing_subnet_name" {
  description = "The name of the existing Subnet."
  type        = string

}

variable "location" {
  description = "location of your existing resources."
  type        = string

}

variable "existing_nsg" {
  description = "Existing NSG."
  type        = string
 
}

variable "workspace_name" {
  description = "Name of AVD workspace"
  type        = string
 
}

variable "host_pool_name" {
  description   = "Host pool name"
  type          = string
}
variable "host_pool_type" {
  description   = "Host pool type"
  type          = string

}
variable "load_balancer_type" {
  description   = "Load Balancer Type"
  type          = string
}
variable "max_session_hosts" {
  description   = "Maximum session hosts allowed"
  type          = number

}
variable "application_group_name" {
  description     = "Name of application group name"
  type            = string

}
variable "session_host_vm_name" {
  description     = "Name of Session Host VM"
  type            = string

}

variable "session_host_count" {
  description     = "Number of Session Host VM's"
  type            = number
}
variable "vm_size"{
  description    = "Size of session host VM"
  type           = string

}
variable "vm_image_publisher" {
  description = "The publisher of the VM image."
  type        = string

}

variable "vm_image_offer" {
  description = "The offer of the VM image."
  type        = string

}

variable "vm_image_sku" {
  description = "The SKU of the VM image."
  type        = string

}

variable "vm_image_version" {
  description = "The version of the VM image."
  type        = string

}
variable "os_disk_caching" {
  description = "The type of caching for the OS disk (None, ReadOnly, ReadWrite)."
  type        = string

}

variable "os_disk_storage_account_type" {
  description = "The type of storage account for the OS disk (Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS)."
  type        = string

}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB. If 0, Azure defaults will be used based on image."
  type        = number

}
variable "admin_username" {
  description   = "Username for session host VMs"
  type          = string

}









