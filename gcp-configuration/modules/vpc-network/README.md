<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.43.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 6.43.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | >= 6.43.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_network.vpc_network](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_network) | resource |
| [google-beta_google_compute_subnetwork.vpc_subnet](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_subnetwork) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | Default routes (0.0.0.0/0) will be deleted immediately after network creation | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. | `string` | `"Default VPC for Imprivata VMs"` | no |
| <a name="input_google_api_access"></a> [google\_api\_access](#input\_google\_api\_access) | When enabled, VMs in this subnetwork without external IP addresses<br>    can access Google APIs and services by using Private Google Access. | `bool` | `true` | no |
| <a name="input_ip_cidr_range"></a> [ip\_cidr\_range](#input\_ip\_cidr\_range) | The range of internal addresses that are owned by this subnetwork.<br>    Ranges must be unique and non-overlapping within a network. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The purpose of the resource.<br>    This field can be either PRIVATE, REGIONAL\_MANAGED\_PROXY, GLOBAL\_MANAGED\_PROXY,<br>    PRIVATE\_SERVICE\_CONNECT, PEER\_MIGRATION or PRIVATE\_NAT | `any` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | The GCP region for this subnetwork | `any` | n/a | yes |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | An array of configurations for secondary IP ranges for VM instances contained in this subnetwork.<br>    The primary IP of such VM must belong to the primary ipCidrRange of the subnetwork.<br>    The alias IPs may belong to either primary or secondary ranges. | <pre>list(object({<br>    range_name    = string,<br>    ip_cidr_range = string<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | A name for new VPC | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_net_gateway"></a> [net\_gateway](#output\_net\_gateway) | The default IPv4 gateway address associated with the VPC network. |
| <a name="output_net_name"></a> [net\_name](#output\_net\_name) | The name of the VPC network. |
| <a name="output_net_self_link"></a> [net\_self\_link](#output\_net\_self\_link) | The self-link (fully qualified resource path) of the VPC network. |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The unique identifier (ID) of the VPC network resource. |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | The unique identifier (ID) of the subnetwork resource. |
| <a name="output_subnet_self_link"></a> [subnet\_self\_link](#output\_subnet\_self\_link) | The self-link (fully qualified resource path) of the subnetwork. |
<!-- END_TF_DOCS -->