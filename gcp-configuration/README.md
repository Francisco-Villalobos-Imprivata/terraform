# Imprivata VM Deployment on GCP

This Terraform module set allows you to deploy **Imprivata VM instances** in Google Cloud Platform (GCP).  
It supports two main modes:
- **Attach VMs to an existing VPC/Subnet** `deploy_network.enable = false`
with provided network configuration to `network_interface`
- **Create a new VPC with subnets (and optional secondary ranges)** (`deploy_network.enable = true`)
`deploy_network.create_nat = true` **Deploy Cloud NAT**
- You can also enable default or custom **firewall rules**.

Additional configuration notes:

- **region** – The GCP region where the VM will be created. Must belong to a valid region such as us-central1,
us-east1, us-east4, us-east5, us-south1, us-west1, us-west2, us-west3, or us-west4.

- **instance_type** – The machine type for the VM. Only e2-standard-(2/4/8) or n2-standard-(2/4/8) are allowed.
Example: "e2-standard-4".

- **vm_disk_size** Specifies the size of the VM boot disk in gigabytes (GB). Must be greater than or equal to 300GB. 

### 1. Minimal Example – Existing Network
```hcl
project_id = "my-gcp-project"
region     = "us-central1"
zone       = "us-central1-a"

instances = {
  vm1 = {
    instance_name = "imprivata-vm1"
    instance_type = "e2-standard-2"
  }
}
network_interface = [
  {
    subnetwork     = "projects/PROJECT_ID/regions/us-east4/subnetworks/default"
  }
]
```        
---

## Running Terraform on GCP

This guide describes how to authenticate and run Terraform with Google Cloud Platform (GCP).
Terraform supports multiple authentication flows:

* Service Account authentication with key file
``` 
 export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/key.json" 
```
* Direct user authentication
```
gcloud auth application-default login
```
* User authentication with Service Account impersonation. First login as user.
```
export GOOGLE_IMPERSONATE_SERVICE_ACCOUNT=SERVICE_ACCOUNT@PROJECT.gserviceaccount.com
```

### Prerequisites

Install Terraform https://developer.hashicorp.com/terraform/downloads

Install Google Cloud SDK https://cloud.google.com/sdk/docs/install

Have access to a GCP project and the required IAM roles (e.g., roles/compute.admin, roles/iam.serviceAccountUser).

### Terraform State Backend

By default, Terraform stores the state file (terraform.tfstate) locally on your machine.
For team collaboration and safe state management, it is strongly recommended to configure a remote backend.

In GCP, the typical choice is a Google Cloud Storage (GCS) bucket. Example backend.tf configuration:
```hcl
terraform {
  backend "gcs" {
    bucket      = "my-terraform-state-bucket"
    prefix      = "infra"
    credentials = "key.json" 
  }
}
```
* bucket → Name of your GCS bucket where the state will be stored. With versioning enabled to track state history.
* prefix → Path inside the bucket for organizing states (e.g., per environment).
* credentials → Optional; omit if you already export GOOGLE_APPLICATION_CREDENTIALS or use impersonation.

### Terraform Workflow
Follow these steps to manage your infrastructure with Terraform:

Initialize Terraform
```
terraform init
```

Validate configuration
```hcl
terraform validate
```

Plan the deployment
```hcl
terraform plan -var-file="terraform.tfvars"
```

Apply the configuration
```hcl
terraform apply -var-file="terraform.tfvars"

```

Destroy deployment

```hcl
terraform destroy -var-file="terraform.tfvars"
```

### Steps After terraform apply and Final Configuration
After running terraform apply, Terraform will output instance parameters along with ready-to-use
gcloud commands for connecting to your VM.

If you deployed with a private network, the output will also include a command for creating
a local port-forward via IAP.
```hcl
INSTANCE_PARAMS = {
  "service" = {
    "console_connection" = "gcloud compute connect-to-serial-port --project=sandbox-471714 --zone=us-east4-a --port=1 imprivata-svc"
    "instance_ip"        = "192.168.10.2"
    "instance_name"      = "imprivata-svc"
    "port_forward"       = "gcloud compute start-iap-tunnel --project=sandbox-471714 --zone=us-east4-a imprivata-svc 81 --local-host-port=localhost:81"
  }
}
```
1. Connect to the VM console
Run the `console_connection` command from the outputs
2. Finish network configuration inside the VM. Log in using the provided console access.
By default, GCP assigns a **/32** netmask.
Update the netmask to the correct value for your subnet (e.g., /24 or whatever your VPC subnet defines).
3. (If using private networking) set up a local `port-forward`.
This will allow you to access the instance service on your local machine at http://localhost:81.
___

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.43.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 6.43.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_firewall_rules"></a> [firewall\_rules](#module\_firewall\_rules) | ./modules/firewall | n/a |
| <a name="module_instance"></a> [instance](#module\_instance) | ./modules/vm-instance | n/a |
| <a name="module_nat"></a> [nat](#module\_nat) | ./modules/nat | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc-network | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_network"></a> [deploy\_network](#input\_deploy\_network) | Configuration for creating a new VPC network (optional).<br>    - enable = true → create a new VPC network<br>    - create\_nat = (bool, optional) -> Cloud Router and Cloud NAT will be provisioned to provide outbound internet access for instances without external IPs<br>    - ip\_cidr\_range (string, optional): Primary CIDR range for subnet<br>    - secondary\_ranges (list, optional): List of secondary IP ranges for the subnet | <pre>object({<br>    enable        = bool<br>    create_nat    = optional(bool)<br>    ip_cidr_range = optional(string)<br>    secondary_ranges = optional(list(object({<br>      range_name    = string,<br>      ip_cidr_range = string<br>    })))<br>  })</pre> | <pre>{<br>  "enable": false<br>}</pre> | no |
| <a name="input_enable_firewall"></a> [enable\_firewall](#input\_enable\_firewall) | List of network names where default firewall rules should be deployed. Empty to skip. | `list(string)` | `[]` | no |
| <a name="input_firewal_rules"></a> [firewal\_rules](#input\_firewal\_rules) | Custom firewall rules to apply on the VPC. | `list` | `[]` | no |
| <a name="input_imprivata_image"></a> [imprivata\_image](#input\_imprivata\_image) | Default Imprivata image | `string` | `"eam25-3-0g4build9"` | no |
| <a name="input_imprivata_project_image"></a> [imprivata\_project\_image](#input\_imprivata\_project\_image) | Default Imprivata project | `string` | `"sandbox-471714"` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Map of VM instance definitions. | <pre>map(object({<br>    instance_name = string<br>    instance_type = string<br>  }))</pre> | n/a | yes |
| <a name="input_network_interface"></a> [network\_interface](#input\_network\_interface) | List of existing network interface definitions to attach VM(s) to existing VPC/subnet. | `list` | `[]` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which the resource will be created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone that the machine should be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Cloud_NAT_IP"></a> [Cloud\_NAT\_IP](#output\_Cloud\_NAT\_IP) | The external IP address reserved and used by Cloud NAT |
| <a name="output_INSTANCE_PARAMS"></a> [INSTANCE\_PARAMS](#output\_INSTANCE\_PARAMS) | A map of instance names to their IPs. |
| <a name="output_NETWORK_PARAMS"></a> [NETWORK\_PARAMS](#output\_NETWORK\_PARAMS) | Network parameters created with VPC module |
<!-- END_TF_DOCS -->