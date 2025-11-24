variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "network" {
  description = "Name of the network this set of firewall rules applies to."
  type        = string
}

variable "rules" {
  description = "List of custom rule definitions."
  default     = []
  type = list(object({
    name                    = string
    description             = optional(string)
    direction               = optional(string)
    priority                = optional(number)
    ranges                  = optional(list(string))
    source_tags             = optional(list(string))
    source_service_accounts = optional(list(string))
    target_tags             = optional(list(string))
    target_service_accounts = optional(list(string))
    allow = optional(list(object({
      protocol = optional(string)
      ports    = optional(list(string))
    })))
    deny = optional(list(object({
      protocol = optional(string)
      ports    = optional(list(string))
    })))
    log_config = optional(object({
      metadata = optional(string)
    }))
  }))
}

variable "suffix_name" {
  description = "Use suffix in the firewall name"
  type        = string
  default     = null
}