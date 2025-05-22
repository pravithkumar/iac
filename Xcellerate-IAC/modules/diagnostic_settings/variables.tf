variable "settings" {
  type = object({
    name                           = string
    target_resource_id             = string
    log_analytics_workspace_id     = optional(string)
    storage_account_id             = optional(string)
    eventhub_name                  = optional(string)
    log_analytics_destination_type = optional(string)
    eventhub_authorization_rule_id = optional(string)
    partner_solution_id            = optional(string)

    metric = optional(list(object({
      category = string
      enabled  = bool
    })))

    enabled_log = optional(list(object({
      category       = string
      category_group = optional(string, null)
    })))
    
  })
}