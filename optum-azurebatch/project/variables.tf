variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" {
  type = list(string)
}
variable "subnets" {
  type = list(object({
    name             = string
    address_prefixes = list(string)
    nsg_id           = optional(string)
    route_table_id   = optional(string)
    delegations = optional(list(object({
      name          = string
      service_name  = string
      actions       = list(string)
    })))
  }))
}
variable "storage_account_name" {}
variable "key_vault_name" {}
variable "batch_account_name" {}
variable "pool_name" {}
variable "vm_size" {}
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_version" {}
variable "node_agent_sku_id" {}
variable "target_dedicated_nodes" {}
variable "target_low_priority_nodes" {}
variable "start_task_command_line" {}
