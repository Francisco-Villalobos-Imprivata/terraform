variable "name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created"
  type        = string
}

variable "address_space" {
  description = "(Optional) The address space that is used the virtual network. You can supply more than one address space."
  type        = list(string)
  default     = null
}

variable "subnets" {
  description = "(Optional) One or more `subnet` blocks as defined below."
  type = list(object({
    name              = string
    address_prefixes  = list(string)
    security_group    = optional(string)
    service_endpoints = optional(list(string))
  }))
  default = []

}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}
