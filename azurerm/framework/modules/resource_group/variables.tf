variable "name" {
  description = "The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."
  type        = string
}

variable "location" {
  description = "The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
  type        = string
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group"
  type        = map(any)
  default     = {}
}

variable "aset" {
  description = "Availability Set configuration."
  type = object({
    platform_fault_domain_count  = optional(number, 2)
    update_domain_count          = optional(number, 2)
    proximity_placement_group_id = optional(string)
    managed                      = optional(bool, true)
    vm_network_interface = object({
      ip_configuration = object({
        name                          = string
        subnet_id                     = string
        private_ip_address_allocation = string
      })
    })
  })
  default = null
}
