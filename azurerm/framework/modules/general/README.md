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
| [azurerm_availability_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set) | resource |
| [azurerm_network_security_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aset"></a> [aset](#input\_aset) | (Required) Availability Set configuration.<br/><br/>  platform\_update\_domain\_count - (Optional) Specifies the number of update domains that are used. Defaults to 5. Changing this forces a new resource to be created.<br/>  platform\_fault\_domain\_count - (Optional) Specifies the number of fault domains that are used. Defaults to 3. Changing this forces a new resource to be created.<br/>  proximity\_placement\_group\_id - (Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created.<br/>  managed - (Optional) Specifies whether the availability set is managed or not. Possible values are true (to specify aligned) or false (to specify classic). Default is true. Changing this forces a new resource to be created. | <pre>object({<br/>    platform_update_domain_count = optional(number)<br/>    platform_fault_domain_count  = optional(number)<br/>    proximity_placement_group_id = optional(string)<br/>    managed                      = optional(bool)<br/>  })</pre> | <pre>{<br/>  "managed": true,<br/>  "platform_fault_domain_count": 3,<br/>  "platform_update_domain_count": 5<br/>}</pre> | no |
| <a name="input_aset_name"></a> [aset\_name](#input\_aset\_name) | (Required) The name of the Availability Set. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | (Required) The location/region where the virtual network is created. Changing this forces a new resource to be created | `string` | n/a | yes |
| <a name="input_nic_nsg"></a> [nic\_nsg](#input\_nic\_nsg) | (Optional) Network Security Group configuration.<br/>  security\_rules - (Optional) One or more `security_rule` blocks as defined below.<br/>    name - (Required) The name of the security rule.<br/>    protocol - (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).<br/>    source\_port\_range - (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source\_port\_ranges is not specified.<br/>    destination\_port\_range - (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination\_port\_ranges is not specified.<br/>    source\_address\_prefix - (Optional) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source\_address\_prefixes is not specified.<br/>    destination\_address\_prefix - (Optional) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination\_address\_prefixes is not specified.<br/>    access - (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.<br/>    priority - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.<br/>    direction - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound. | <pre>object({<br/>    security_rules = optional(list(object({<br/>      name                       = string<br/>      protocol                   = string<br/>      source_port_range          = optional(string)<br/>      destination_port_range     = optional(string)<br/>      source_address_prefix      = optional(string)<br/>      destination_address_prefix = optional(string)<br/>      access                     = string<br/>      priority                   = number<br/>      direction                  = string<br/>    })), [])<br/>  })</pre> | n/a | yes |
| <a name="input_nic_nsg_name"></a> [nic\_nsg\_name](#input\_nic\_nsg\_name) | (Required) The name of the VM NIC Network Security Group. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags which should be assigned to the Resource. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aset_id"></a> [aset\_id](#output\_aset\_id) | The Name of the Availability Set. |
| <a name="output_aset_name"></a> [aset\_name](#output\_aset\_name) | The Name of the Availability Set. |
| <a name="output_nic_nsg_id"></a> [nic\_nsg\_id](#output\_nic\_nsg\_id) | The ID of the VM NIC Network Security Group. |
<!-- END_TF_DOCS -->