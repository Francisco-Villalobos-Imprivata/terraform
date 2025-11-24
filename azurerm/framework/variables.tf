variable "azure_subscription_id" {
  description = "The Subscription ID which should be used. This can also be sourced from the ARM_SUBSCRIPTION_ID Environment Variable."
  type        = string
}

variable "azure_client_id" {
  description = "The Client ID which should be used. This can also be sourced from the ARM_CLIENT_ID Environment Variable."
  type        = string
  default     = null
}

variable "location" {
  description = "The Azure Region where the resources should exist."
  type        = string
  validation {
    condition     = contains(["East US", "Central US", "West US", "North Central US"], var.location)
    error_message = "Please select a valid Azure region. Supported regions are: East US, Central US, West US, North Central US."
  }
}

variable "project_name" {
  description = "Project (Client) name."
  type        = string
  default     = "imp"
}

variable "workload_name" {
  description = "Workload name (eg. db, svc)."
  type        = string
  default     = "app"
}

variable "env_name" {
  description = "Environment name (eg. dev, test, prod)."
  type        = string
}

variable "custom_resource_group_name" {
  description = "The name of the Custom resource group."
  type        = string
  default     = null
}

variable "virtual_network" {
  description = "Azure Virtual Network configuration."
  type = object({
    address_space = optional(list(string))
    subnets = list(object({
      name              = string
      address_prefixes  = list(string)
      security_group    = optional(string)
      service_endpoints = optional(list(string))
    }))

  })
  default = null
}

variable "custom_virtual_network" {
  description = "Custom Azure Virtual Network configuration."
  type = object({
    name                = string
    subnet_name         = string
    resource_group_name = string
  })
  default = null
}

variable "storage_account" {
  description = "Azure Storage Account configuration for VM boot diagnostics."
  type = object({
    account_kind             = optional(string)
    account_tier             = optional(string)
    account_replication_type = optional(string)
    access_tier              = optional(string)
  })
  default = null
  validation {
    condition     = var.storage_account != null ? contains(["Storage", "StorageV2"], var.storage_account.account_kind) : true
    error_message = "Please select a valid storage account kind. Supported kinds are: Storage, StorageV2."
  }
  validation {
    condition     = var.storage_account != null ? contains(["Standard"], var.storage_account.account_tier) : true
    error_message = "Please select a valid storage account tier. Supported tiers are: Standard."
  }
  validation {
    condition     = var.storage_account != null ? contains(["LRS", "GRS"], var.storage_account.account_replication_type) : true
    error_message = "Please select a valid storage account replication type. Supported types are: LRS, GRS."
  }
}

variable "custom_storage_account" {
  description = "Custom Azure Storage Account configuration for VM boot diagnostics."
  type = object({
    name                = string
    resource_group_name = string
  })
  default = null
}

variable "virtual_appliances" {
  description = "List of DB virtual appliances."
  type = list(object({
    admin_username      = optional(string)
    size                = string
    availability_set_id = optional(string)
    os_disk = optional(object({
      caching              = optional(string, "ReadWrite")
      storage_account_type = optional(string, "Premium_LRS")
    }))
    source_image_reference = optional(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
    vm_nic_subnet_name = optional(string)
    instance           = number
  }))
  default = []
  validation {
    condition     = length(var.virtual_appliances) <= 10
    error_message = "Please deploy up to 10 appliances (VMs) in the one Azure resource group. You have specified ${length(var.virtual_appliances)} appliances."
  }
  validation {
    condition     = alltrue([for k, v in var.virtual_appliances : contains(["Standard_F4s_v2", "Standard_F8s_v2"], v.size)])
    error_message = "Please select a valid VM size for the appliance. Supported sizes are: Standard_F4s_v2, Standard_F8s_v2."
  }
}

variable "onesign_vhd_offer" {
  description = "The Imprivata OneSign Virtual Hard Drive offer attributes."
  type = object({
    publisher = optional(string)
    offer_id  = optional(string)
    plan_id   = optional(string)
    version   = optional(string)
  })
  default = {
    publisher = "imprivatainc1580479939967"
    offer_id  = "onesign_vhd"
    plan_id   = "onesign_25-4-99_g5_plan1"
    version   = "latest"
  }
}

variable "vm_nic_subnet_name" {
  description = "Reference to the subnet name defined in the 'virtual_network' block."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}
