variable "vm_network_interface" {
  description = "(Required) The network interface configuration for the VM."
  type = object({
    nic_nsg_id = string
    ip_configuration = object({
      name                          = optional(string, "internal")
      subnet_id                     = string
      private_ip_address_allocation = optional(string, "Dynamic")
    })
  })
}

variable "name" {
  description = "(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created."
  type        = string
}

variable "admin_username" {
  description = "(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  type        = string
  default     = "vmadmin"
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created"
  type        = string
}

variable "size" {
  description = "(Required) The size of the Virtual Machine. A list of possible values can be found in the 'Size' section of the Azure documentation: https://docs.microsoft.com/en-us/azure/virtual-machines/sizes"
  type        = string
}

variable "availability_set_id" {
  description = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "disable_password_authentication" {
  description = "(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  type        = bool
  default     = true
}

variable "boot_diagnostics_storage_uri" {
  description = "(Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor."
  type        = string
  default     = null
}

variable "os_disk" {
  description = <<EOF
  (Required) The OS disk configuration for the Virtual Machine.

  caching - (Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.
  storage_account_type - (Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS. Changing this forces a new resource to be created.

  EOF
  type = object({
    caching              = optional(string, "ReadWrite")
    storage_account_type = optional(string, "Standard_LRS")
    disk_size_gb         = optional(number)
  })
}

variable "source_image_reference" {
  description = <<EOF
  (Required) The source image reference for the Virtual Machine.

  publisher - (Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created.
  offer - (Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created.
  sku - (Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created.
  version - (Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created.

  EOF
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "tags" {
  description = "(Optional) A mapping of tags which should be assigned to this Virtual Machine."
  type        = map(any)
  default     = {}
}

variable "vm_ssh_tls_private_key" {
  description = "The private key for TLS authentication."
  type = object({
    algorithm = string
    rsa_bits  = number
  })
  default = {
    algorithm = "RSA"
    rsa_bits  = 4096
  }
}
