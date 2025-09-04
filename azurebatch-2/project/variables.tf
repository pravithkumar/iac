variable "location" {
  type = string
}

variable "resource_group_name" {
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


variable "key_vault_id" {
  type = string
}
variable "key_vault_url" {
  type = string
}

variable "user_assigned_identity_id" {
  type = string
}


variable "key_vault_id" {
  type = string
}

variable "user_assigned_identity_object_id" {
  type = string
}


