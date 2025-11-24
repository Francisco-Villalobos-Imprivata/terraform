<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.41.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.41.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aset_name"></a> [aset\_name](#module\_aset\_name) | ./modules/name_generator | n/a |
| <a name="module_general"></a> [general](#module\_general) | ./modules/general | n/a |
| <a name="module_nic_nsg_name"></a> [nic\_nsg\_name](#module\_nic\_nsg\_name) | ./modules/name_generator | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | ./modules/resource_group | n/a |
| <a name="module_resource_group_name"></a> [resource\_group\_name](#module\_resource\_group\_name) | ./modules/name_generator | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account | n/a |
| <a name="module_storage_account_name"></a> [storage\_account\_name](#module\_storage\_account\_name) | ./modules/name_generator | n/a |
| <a name="module_virtual_appliance"></a> [virtual\_appliance](#module\_virtual\_appliance) | ./modules/virtual_machine | n/a |
| <a name="module_virtual_appliance_name"></a> [virtual\_appliance\_name](#module\_virtual\_appliance\_name) | ./modules/name_generator | n/a |
| <a name="module_virtual_network"></a> [virtual\_network](#module\_virtual\_network) | ./modules/virtual_network | n/a |
| <a name="module_virtual_network_name"></a> [virtual\_network\_name](#module\_virtual\_network\_name) | ./modules/name_generator | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.custom](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | The Client ID which should be used. This can also be sourced from the ARM\_CLIENT\_ID Environment Variable. | `string` | `null` | no |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | The Subscription ID which should be used. This can also be sourced from the ARM\_SUBSCRIPTION\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_custom_resource_group_name"></a> [custom\_resource\_group\_name](#input\_custom\_resource\_group\_name) | The name of the Custom resource group. | `string` | `null` | no |
| <a name="input_custom_storage_account"></a> [custom\_storage\_account](#input\_custom\_storage\_account) | Custom Azure Storage Account configuration for VM boot diagnostics. | <pre>object({<br/>    name                = string<br/>    resource_group_name = string<br/>  })</pre> | `null` | no |
| <a name="input_custom_virtual_network"></a> [custom\_virtual\_network](#input\_custom\_virtual\_network) | Custom Azure Virtual Network configuration. | <pre>object({<br/>    name                = string<br/>    subnet_name         = string<br/>    resource_group_name = string<br/>  })</pre> | `null` | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name (eg. dev, test, prod). | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the resources should exist. | `string` | n/a | yes |
| <a name="input_onesign_vhd_offer"></a> [onesign\_vhd\_offer](#input\_onesign\_vhd\_offer) | The Imprivata OneSign Virtual Hard Drive offer attributes. | <pre>object({<br/>    publisher = optional(string)<br/>    offer_id  = optional(string)<br/>    plan_id   = optional(string)<br/>    version   = optional(string)<br/>  })</pre> | <pre>{<br/>  "offer_id": "onesign_vhd",<br/>  "plan_id": "onesign_25-4-99_g5_plan1",<br/>  "publisher": "imprivatainc1580479939967",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project (Client) name. | `string` | `"imp"` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | Azure Storage Account configuration for VM boot diagnostics. | <pre>object({<br/>    account_kind             = optional(string)<br/>    account_tier             = optional(string)<br/>    account_replication_type = optional(string)<br/>    access_tier              = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |
| <a name="input_virtual_appliances"></a> [virtual\_appliances](#input\_virtual\_appliances) | List of DB virtual appliances. | <pre>list(object({<br/>    admin_username      = optional(string)<br/>    size                = string<br/>    availability_set_id = optional(string)<br/>    os_disk = optional(object({<br/>      caching              = optional(string, "ReadWrite")<br/>      storage_account_type = optional(string, "Premium_LRS")<br/>    }))<br/>    source_image_reference = optional(object({<br/>      publisher = string<br/>      offer     = string<br/>      sku       = string<br/>      version   = string<br/>    }))<br/>    vm_nic_subnet_name = optional(string)<br/>    instance           = number<br/>  }))</pre> | `[]` | no |
| <a name="input_virtual_network"></a> [virtual\_network](#input\_virtual\_network) | Azure Virtual Network configuration. | <pre>object({<br/>    address_space = optional(list(string))<br/>    subnets = list(object({<br/>      name              = string<br/>      address_prefixes  = list(string)<br/>      security_group    = optional(string)<br/>      service_endpoints = optional(list(string))<br/>    }))<br/><br/>  })</pre> | `null` | no |
| <a name="input_vm_nic_subnet_name"></a> [vm\_nic\_subnet\_name](#input\_vm\_nic\_subnet\_name) | Reference to the subnet name defined in the 'virtual\_network' block. | `string` | `null` | no |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | Workload name (eg. db, svc). | `string` | `"app"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Resource Group Name where all resources are deployed. |
| <a name="output_virtual_appliances"></a> [virtual\_appliances](#output\_virtual\_appliances) | Attributes of the Virtual Appliances. |
<!-- END_TF_DOCS -->