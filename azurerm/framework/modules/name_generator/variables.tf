variable "env_name" {
  description = "Environment name (dev, qa, stg, prod)."
  type        = string
  validation {
    condition     = length(var.env_name) <= 4
    error_message = "The length of Env name \"${var.env_name}\" should be less than 4 symbols: dev, qa, stg, prod."
  }
}

variable "location" {
  description = "Location region."
  type        = string
  validation {
    condition     = lookup(local.location_map, replace(lower(var.location), " ", "_"), false) != false
    error_message = "Location \"${var.location}\" doesn't exit. Please specify the valid one or add new item to the list."
  }
}

variable "project_name" {
  description = "Project (Client) name."
  type        = string
  validation {
    condition     = length(var.project_name) <= 7
    error_message = "The length of Project name \"${var.project_name}\" should be less than 5 symbols."
  }
}

variable "resource_type" {
  description = "Resource type."
  type        = string
  validation {
    condition = (
      lookup(local.resource_abbreviation_map, split("/", var.resource_type)[0], false) != false ?
      lookup(local.resource_abbreviation_map[split("/", var.resource_type)[0]], split("/", var.resource_type)[1], false) != false
      : false
    )
    error_message = "Resource type \"${var.resource_type}\" doesn't exit. Please specify the valid one or add new item to the list."
  }
}

variable "workload_name" {
  description = "Resource workload name."
  type        = string
  validation {
    condition     = length(var.workload_name) <= 3
    error_message = "The length of workload name \"${var.workload_name}\" should be less than 4 symbols."
  }
}

variable "instance" {
  description = "Number of instance."
  type        = number
}
