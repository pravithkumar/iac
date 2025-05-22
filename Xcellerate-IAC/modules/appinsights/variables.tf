variable "settings" {
  description = "App Service Plan configuration."
  type = object({
    name                       = string
    location                   = string
    resource_group_name        = string
    application_type           = string
    internet_ingestion_enabled = optional(bool, false)
    internet_query_enabled     = optional(bool, true)
    workspace_id               = optional(string)
    tags                       = optional(map(string), null)
  })
}
