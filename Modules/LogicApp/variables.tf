variable "logic_app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_service_plan_id" {
  type = string
}

variable "workflow_definition" {
  type = string
}

variable "tags" {
  type = map(string)
}