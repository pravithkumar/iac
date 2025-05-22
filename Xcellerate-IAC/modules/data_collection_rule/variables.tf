variable "settings" {
  type = object({
    name                        = string
    resource_group_name         = string
    location                    = string
    data_collection_endpoint_id = optional(string)
    kind                        = optional(string)
    tags                        = optional(map(string))

    destinations = optional(object({
      log_analytics = list(object({
        name                  = string
        workspace_resource_id = string
      }))
    }))

    data_flow = optional(list(object({
      streams      = list(string)
      destinations = list(string)
    })))

    data_sources = optional(object({
      extension = optional(list(object({
        name           = string
        streams        = list(string)
        extension_name = string
        extension_json = optional(string)
      })))

      performance_counter = optional(list(object({
        name                          = string
        counter_specifiers            = list(string)
        sampling_frequency_in_seconds = number
        streams                       = list(string)
      })))
    }))

    data_collection_rule_association = optional(list(object({
      name               = string
      target_resource_id = string
    })))
  })
}
