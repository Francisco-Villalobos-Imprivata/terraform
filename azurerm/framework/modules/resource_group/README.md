<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.41.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.41.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aset"></a> [aset](#input\_aset) | Availability Set configuration. | <pre>object({<br/>    platform_fault_domain_count  = optional(number, 2)<br/>    update_domain_count          = optional(number, 2)<br/>    proximity_placement_group_id = optional(string)<br/>    managed                      = optional(bool, true)<br/>    vm_network_interface = object({<br/>      ip_configuration = object({<br/>        name                          = string<br/>        subnet_id                     = string<br/>        private_ip_address_allocation = string<br/>      })<br/>    })<br/>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the Resource Group | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the Resource Group. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the Resource Group. |
<!-- END_TF_DOCS -->