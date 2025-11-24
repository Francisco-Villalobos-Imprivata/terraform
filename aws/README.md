
# Runbook: AWS Terraform Deployment

## Overview

This directory contains Terraform code to deploy EC2-based appliances in AWS. It supports both new VPC creation and deployment into existing VPCs/subnets, using a modular structure for compute, networking, and IAM.

---

## Input Parameters (Terraform Variables)

| Variable                      | Type     | Default/Example                | Description                                                      |
|-------------------------------|----------|-------------------------------|------------------------------------------------------------------|
| `machine_prefix`              | String   | `imp`                         | Prefix for resource names.                                       |
| `image_id`                    | String   | (AMI ID)                      | AMI to use for EC2 instances.                                    |
| `appliances`                  | List     | See example tfvars            | List of appliance instance definitions.                          |
| `subnet_id`                   | String   | (optional)                    | (For existing VPC) Subnet to deploy into.                        |
| `vpc_cidr`                    | String   | `10.0.0.0/16`                 | (For new VPC) CIDR block for VPC.                                |
| `subnet_cidrs`                | List     | `["10.0.1.0/24"]`            | (For new VPC) CIDR blocks for subnets.                           |
| `security_group_allow_cidrs`  | List     | `["0.0.0.0/0"]`              | List of CIDRs allowed in security group.                         |
| `security_group_allow_ports`  | List     | See example tfvars            | List of ports and descriptions to allow.                         |

See [`variables.tf`](./variables.tf) for the full list and details.

---

## Prerequisites

- **[Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)** must be installed and available in your system's PATH.
- **AWS credentials** configured (via environment variables, `~/.aws/credentials`, or similar).
- Sufficient AWS permissions to create VPCs, subnets, EC2 instances, security groups, and IAM roles.

---

## AWS Cloud Resources Restrictions

1. **Regions**: Only deploy in supported AWS regions (e.g., `us-east-1`, `us-west-2`).
2. **EC2 Instance Types**: Use only supported types (e.g., `t3.medium`, `m5.large`).
3. **Number of Appliances**: Recommended <= 10 per deployment.
4. **AMI**: Ensure the AMI ID is valid in your target region.

---

## What the Terraform Code Does

1. **Initializes Terraform**
	Runs `terraform init` in the AWS directory to initialize the working directory.
2. **Validates Terraform Configuration**
	Runs `terraform validate` to ensure the configuration is syntactically valid.
3. **Creates a Terraform Plan**
	Runs `terraform plan` with the specified variable file and outputs the plan.
4. **Applies the Terraform Plan**
	Runs `terraform apply` using the provided variable file.
5. **Logs Progress**
	Outputs log messages at each step.

---

## Usage Examples

### 1. Prepare a variable file

Use one of the example variable files in [`examples/`](./examples/):

- [`new_vpc.tfvars`](./examples/new_vpc.tfvars): Deploys into a new VPC and subnets.
- [`existing_vpc.tfvars`](./examples/existing_vpc.tfvars): Deploys into an existing subnet.

Edit the file as needed for your environment.

### 2. Initialize Terraform

```sh
terraform init
```

### 3. Validate the configuration

```sh
terraform validate
```

### 4. Plan the deployment

```sh
terraform plan -var-file="examples/existing_vpc.tfvars"
```

### 5. Apply the deployment

```sh
terraform apply -var-file="examples/existing_vpc.tfvars"
```

---

## Outputs

See [`outputs.tf`](./outputs.tf) for details. Key outputs include:

- `ec2_instance_profile`: Name of the IAM instance profile.
- `security_group_id`: Security group ID.
- `appliances`: List of deployed EC2 instances with details.

---

## Cleanup

To destroy all resources created by this project:

```sh
terraform destroy -var-file="examples/existing_vpc.tfvars"
```

---

## Troubleshooting

- **Terraform Not Found:**
  Ensure Terraform CLI is installed and added to your system's PATH.

- **AWS Credentials Not Found:**
  Ensure your AWS credentials are configured and valid.

- **Permission Issues:**
  Ensure your AWS user/role has sufficient permissions to create and manage resources.

- **Terraform Errors:**
  Review the log output for details on any errors during initialization, validation, planning, or applying.

---

## Notes

- Security group rules default to allow SSH (22), HTTP (81), HTTPS (443), and DB (1521) from specified CIDRs.
- The IAM role grants SSM access for remote management.
