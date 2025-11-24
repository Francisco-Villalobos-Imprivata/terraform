<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.43.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 6.43.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 6.43.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_address.static](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_instance.imprivata](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_image.imprivata_image](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attached_disk"></a> [attached\_disk](#input\_attached\_disk) | List of existing persistent disks to attach to the VM instance.<br>    Each object represents one disk:<br>    - `source` (string, required): The full self\_link of the disk to attach.<br>    - `device_name` (string, required): The name by which the disk is exposed to the guest OS.<br>    - `mode` (string, optional): The access mode. Default is "READ\_WRITE".<br>        Allowed values:<br>      - "READ\_WRITE": The disk is attached in read/write mode (default).<br>      - "READ\_ONLY" : The disk is attached in read-only mode. | <pre>list(object({<br>    source      = string<br>    device_name = string<br>    mode        = optional(string, "READ_WRITE")<br>  }))</pre> | `[]` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Enable deletion protection on this instance | `bool` | `true` | no |
| <a name="input_deploy_network"></a> [deploy\_network](#input\_deploy\_network) | When enabled, the parameter will create a static IP address for the VM | `bool` | n/a | yes |
| <a name="input_firewall_tags"></a> [firewall\_tags](#input\_firewall\_tags) | A list of network tags to attach to the instance. | `list` | `[]` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | A custom hostname for the instance. | `string` | `""` | no |
| <a name="input_image"></a> [image](#input\_image) | The image name provided by Imprivata. | `any` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | A unique name for the VM | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The machine type to create. Use one from: e2-standard-(2/4/8), n2-standard-(2/4/8) | `any` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs assigned to the instance. | `map` | `{}` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Metadata key/value pairs to make available from within the instance"<br>    More info: https://cloud.google.com/compute/docs/metadata/predefined-metadata-keys | `map` | <pre>{<br>  "enable-oslogin": "TRUE"<br>}</pre> | no |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | List of network interface configurations for the VM(s).<br>    Each object must specify either a `network` or `subnetwork` to attach the interface.<br>    - `network` (string, optional): Name or self\_link of the VPC network.<br>    - `subnetwork` (string, optional): Name or self\_link of the subnetwork.<br>    - `subnet_project` (string, optional): Project ID if the subnetwork is in a Shared VPC host project.<br>    - `stack_type` (string, optional): Stack type for the NIC. Default is "IPV4\_ONLY". Use "IPV4\_IPV6" if dual stack is required.<br>    - `access_config` (object, optional): Defines external IP (public) config:<br>      - `nat_ip` (string, optional): Reserved static external IP. Omit for ephemeral.<br>      - `tier` (string, optional): Network service tier ("PREMIUM" or "STANDARD").<br>    - `static_ip` (string, optional): Internal (private) static IP to assign.<br>    - `alias_ip_ranges` (list(object), optional): Alias IPs to assign for secondary ranges:<br>      - `ip_range` (string): CIDR block or specific IP.<br>      - `name_range` (string): Name of the secondary range in the subnetwork. | <pre>list(object({<br>    network        = optional(string)<br>    subnetwork     = optional(string)<br>    subnet_project = optional(string)<br>    stack_type     = optional(string, "IPV4_ONLY")<br>    access_config = optional(object({<br>      nat_ip = optional(string)<br>      tier   = optional(string)<br>    }), null)<br>    static_ip = optional(string)<br>    alias_ip_ranges = optional(list(object({<br>      ip_range   = string<br>      name_range = string<br>    })))<br>  }))</pre> | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_project_image"></a> [project\_image](#input\_project\_image) | The name of the project where image is located. | `string` | n/a | yes |
| <a name="input_scopes"></a> [scopes](#input\_scopes) | List of OAuth 2.0 scopes to assign to the VM's service account.<br>    Scopes control what Google Cloud APIs the instance can access. | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The service account e-mail address. | `any` | `null` | no |
| <a name="input_shielded_config"></a> [shielded\_config](#input\_shielded\_config) | Enable Shielded VM on the instance.<br>    Shielded VM provides verifiable integrity to prevent against malware and rootkits. | <pre>object({<br>    monitoring  = bool<br>    vtm         = bool<br>    secure_boot = bool<br>  })</pre> | <pre>{<br>  "monitoring": false,<br>  "secure_boot": false,<br>  "vtm": false<br>}</pre> | no |
| <a name="input_vm_disk_size"></a> [vm\_disk\_size](#input\_vm\_disk\_size) | The size of the image in gigabytes. | `number` | `300` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone that the machine should be created in. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_ip"></a> [vm\_ip](#output\_vm\_ip) | The internal (private) IPv4 address assigned to the Compute Engine instance. |
<!-- END_TF_DOCS -->