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
| [google_compute_firewall.rules](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network"></a> [network](#input\_network) | Name of the network this set of firewall rules applies to. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource belongs | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | List of custom rule definitions. | <pre>list(object({<br>    name                    = string<br>    description             = optional(string)<br>    direction               = optional(string)<br>    priority                = optional(number)<br>    ranges                  = optional(list(string))<br>    source_tags             = optional(list(string))<br>    source_service_accounts = optional(list(string))<br>    target_tags             = optional(list(string))<br>    target_service_accounts = optional(list(string))<br>    allow = optional(list(object({<br>      protocol = optional(string)<br>      ports    = optional(list(string))<br>    })))<br>    deny = optional(list(object({<br>      protocol = optional(string)<br>      ports    = optional(list(string))<br>    })))<br>    log_config = optional(object({<br>      metadata = optional(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_suffix_name"></a> [suffix\_name](#input\_suffix\_name) | Use suffix in the firewall name | `string` | `null` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->