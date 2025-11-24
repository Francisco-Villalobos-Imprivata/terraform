<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.external_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_router.cloud-nat-router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.cloud-nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_name"></a> [ip\_name](#input\_ip\_name) | The name of the external static IP address used for Cloud NAT. | `string` | `"imprivata-nat-ip"` | no |
| <a name="input_log_filter"></a> [log\_filter](#input\_log\_filter) | Specifies the type of logging for Cloud NAT. Options: 'ERRORS\_ONLY', 'TRANSLATIONS\_ONLY', 'ALL', or 'NONE'. | `string` | `"ERRORS_ONLY"` | no |
| <a name="input_nat_ip_allocate_option"></a> [nat\_ip\_allocate\_option](#input\_nat\_ip\_allocate\_option) | Specifies how external IP addresses are allocated for Cloud NAT. Options: 'AUTO\_ONLY' or 'MANUAL\_ONLY'. | `string` | `"MANUAL_ONLY"` | no |
| <a name="input_nat_name"></a> [nat\_name](#input\_nat\_name) | The name of the Cloud NAT resource. | `string` | `"imprivata-cloud-nat"` | no |
| <a name="input_network"></a> [network](#input\_network) | The name of the VPC network where the Cloud NAT and router will be deployed. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region in which resources (such as the subnetwork and Cloud NAT) will be created. | `string` | n/a | yes |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | The name of the Cloud Router that manages routes for Cloud NAT. | `string` | `"imprivata-nat-router"` | no |
| <a name="input_source_ip_ranges_to_nat"></a> [source\_ip\_ranges\_to\_nat](#input\_source\_ip\_ranges\_to\_nat) | The source IP ranges within the subnetwork to be translated by NAT. Example values: 'ALL\_IP\_RANGES' or 'PRIMARY\_IP\_RANGE'. | `string` | `"ALL_IP_RANGES"` | no |
| <a name="input_source_subnetwork_ip_ranges_to_nat"></a> [source\_subnetwork\_ip\_ranges\_to\_nat](#input\_source\_subnetwork\_ip\_ranges\_to\_nat) | The option to specify which subnetworks should use NAT. Common values: 'ALL\_SUBNETWORKS\_ALL\_IP\_RANGES', 'ALL\_SUBNETWORKS\_ALL\_PRIMARY\_IP\_RANGES', or 'LIST\_OF\_SUBNETWORKS'. | `string` | `"LIST_OF_SUBNETWORKS"` | no |
| <a name="input_vpc_subnet"></a> [vpc\_subnet](#input\_vpc\_subnet) | The name of the VPC subnetwork to associate with the Cloud NAT configuration. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nat-ip"></a> [nat-ip](#output\_nat-ip) | n/a |
<!-- END_TF_DOCS -->