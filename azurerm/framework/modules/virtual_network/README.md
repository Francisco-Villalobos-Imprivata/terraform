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
| [azurerm_virtual_network.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | (Optional) The address space that is used the virtual network. You can supply more than one address space. | `list(string)` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Optional) One or more `subnet` blocks as defined below. | <pre>list(object({<br/>    name              = string<br/>    address_prefixes  = list(string)<br/>    security_group    = optional(string)<br/>    service_endpoints = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Virtual Network ID. |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | One or more subnet IDs. |
<!-- END_TF_DOCS -->