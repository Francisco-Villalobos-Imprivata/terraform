<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.41.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.7.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.41.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.7.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association) | resource |
| [random_password.vm_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_private_key.ssh](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | (Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. | `string` | `"vmadmin"` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | (Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_boot_diagnostics_storage_uri"></a> [boot\_diagnostics\_storage\_uri](#input\_boot\_diagnostics\_storage\_uri) | (Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. | `string` | `null` | no |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | (Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | (Required) The OS disk configuration for the Virtual Machine.<br/><br/>  caching - (Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite.<br/>  storage\_account\_type - (Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard\_LRS, StandardSSD\_LRS, Premium\_LRS, StandardSSD\_ZRS and Premium\_ZRS. Changing this forces a new resource to be created. | <pre>object({<br/>    caching              = optional(string, "ReadWrite")<br/>    storage_account_type = optional(string, "Standard_LRS")<br/>    disk_size_gb         = optional(number)<br/>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | (Required) The size of the Virtual Machine. A list of possible values can be found in the 'Size' section of the Azure documentation: https://docs.microsoft.com/en-us/azure/virtual-machines/sizes | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | (Required) The source image reference for the Virtual Machine.<br/><br/>  publisher - (Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created.<br/>  offer - (Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created.<br/>  sku - (Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created.<br/>  version - (Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created. | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags which should be assigned to this Virtual Machine. | `map(any)` | `{}` | no |
| <a name="input_vm_network_interface"></a> [vm\_network\_interface](#input\_vm\_network\_interface) | (Required) The network interface configuration for the VM. | <pre>object({<br/>    nic_nsg_id = string<br/>    ip_configuration = object({<br/>      name                          = optional(string, "internal")<br/>      subnet_id                     = string<br/>      private_ip_address_allocation = optional(string, "Dynamic")<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_vm_ssh_tls_private_key"></a> [vm\_ssh\_tls\_private\_key](#input\_vm\_ssh\_tls\_private\_key) | The private key for TLS authentication. | <pre>object({<br/>    algorithm = string<br/>    rsa_bits  = number<br/>  })</pre> | <pre>{<br/>  "algorithm": "RSA",<br/>  "rsa_bits": 4096<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->