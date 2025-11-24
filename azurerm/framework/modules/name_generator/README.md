<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Environment name (dev, qa, stg, prod). | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | Number of instance. | `number` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location region. | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project (Client) name. | `string` | n/a | yes |
| <a name="input_resource_type"></a> [resource\_type](#input\_resource\_type) | Resource type. | `string` | n/a | yes |
| <a name="input_workload_name"></a> [workload\_name](#input\_workload\_name) | Resource workload name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resource_name"></a> [resource\_name](#output\_resource\_name) | The generated name of the Resource according to the name convention. |
<!-- END_TF_DOCS -->