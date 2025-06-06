
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
  default       = "Breadth-first"
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
  default         = "avdsessionhst"
}
variable "vm_size"{
  description    = "Size of session host VM"
  type           = string
  default        = "Standard D2as v5"
}
variable "vm_image_publisher" {
  description = "The publisher of the VM image."
  type        = string
  default     = "MicrosoftWindowsDesktop"
}

variable "vm_image_offer" {
  description = "The offer of the VM image."
  type        = string
  default     = "windows-11"
}

variable "vm_image_sku" {
  description = "The SKU of the VM image."
  type        = string
  default     = "win11-22h2-avd"
}

variable "vm_image_version" {
  description = "The version of the VM image."
  type        = string
  default     = "latest"
}
variable "os_disk_caching" {
  description = "The type of caching for the OS disk (None, ReadOnly, ReadWrite)."
  type        = string
  default     = "ReadWrite"
  }

variable "os_disk_storage_account_type" {
  description = "The type of storage account for the OS disk (Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS)."
  type        = string
  default     = "StandardSSD_LRS"
  }

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB. If 0, Azure defaults will be used based on image."
  type        = number
  default     = 32
  
  }

  variable "availability_type" {
  description = "Specifies the availability option for the VMs ('None', 'AvailabilitySet', or 'AvailabilityZone')."
  type        = string
  default     = "None" 
  validation {
    condition     = contains(["None", "AvailabilitySet", "AvailabilityZone"], var.availability_type)
    error_message = "Availability type must be 'None', 'AvailabilitySet', or 'AvailabilityZone'."
  }
}

variable "availability_set_id" {
  description = "The ID of an existing Availability Set if 'availability_type' is 'AvailabilitySet'."
  type        = string
  default     = "Null" 
}

variable "zones" {
  description = "A list of Availability Zones to deploy VMs into (e.g., ['1', '2']). Required if 'availability_type' is 'AvailabilityZone'."
  type        = list(string)
  default     = ["1"] 
  validation {
    condition     = var.availability_type != "AvailabilityZone" || length(var.zones) > 0
    error_message = "If 'availability_type' is 'AvailabilityZone', 'zones' must be provided and not empty."
  }
}
variable "key_vault_name" {
  description   = "Key vault name"
  type          = string
  default       = "avd-key-vault01"
}

variable "tenant_id" {
  description   = "Tenant ID"
  type          = string
  default       = "188285f7-8f1e-4c0d-a0bc-797e3e38c5b3"
}
variable "object_id" {
  description   = "Object ID"
  type          = string
  default       = "dd6cc140-8996-4c7c-9282-a52dbd15addf"
}

variable "sku_name" {
  description   = "Pricing Tier"
  type          = string
  default       = "Standard"
}

variable "session_host_admin_username_kv_value" {
  description = "The username for the session host VMs, stored in Key Vault."
  type        = string
  sensitive   = true # Mark as sensitive
}

variable "session_host_admin_password_kv_value" {
  description = "The password for the session host VMs, stored in Key Vault."
  type        = string
  sensitive   = true # Mark as sensitive
}













