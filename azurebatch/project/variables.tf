variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "batch_account_name" {
  type = string
}

variable "pool_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "image_publisher" {
  type = string
}

variable "image_offer" {
  type = string
}

variable "image_sku" {
  type = string
}

variable "image_version" {
  type = string
}

variable "node_agent_sku_id" {
  type = string
}

variable "target_dedicated_nodes" {
  type = number
}

variable "target_low_priority_nodes" {
  type = number
}

variable "start_task_command_line" {
  type = string
}

variable "subnet_prefix" {
  type = list(string)
  default = ["10.0.1.0/24"]
}

variable "key_vault_id" {
  type = string
}
variable "key_vault_url" {
  type = string
}
variable "batch_identity_name" {
  type = string
}
