# Runbook: Using `deployOSA.ps1` for Azure Cloud Terraform Deployment

## Overview

The `deployOSA.ps1` PowerShell script automates the process of initializing, validating, planning, and applying a Terraform configuration. It is designed to streamline infrastructure deployment using Terraform in a specified directory, with support for custom plan and variable files.

---

## Input Parameters

| Parameter      | Type     | Default Value           | Description                                                                 |
|----------------|----------|------------------------|-----------------------------------------------------------------------------|
| `TerraformDir` | String   | `framework`            | Directory containing the Terraform configuration to deploy.                 |
| `PlanFile`     | String   | `tfplan`               | Name of the file to store the Terraform plan output.                        |
| `ConfigFile`   | String   | `../osa_config.tfvars` | Path to the Terraform variable definitions file (`.tfvars`).                |
| `AutoApprove`  | Switch   | (not set)              | If specified, skips manual approval before applying the Terraform plan.      |

---

## Prerequisites

- **[Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli)** must be installed and available in your system's PATH.
- **[Azure CLI](https://learn.microsoft.com/uk-ua/cli/azure/install-azure-cli?view=azure-cli-latest)** must be installed and available in your system's PATH.
- **[az login](https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest#az-login)** has been completed and target Subscription selected.
- Ensure you have the necessary permissions to run PowerShell scripts and deploy resources.
- Prepare config .tfvar file with relevant Azure cloud resources configuration and place it beside the `deployOSA.ps1` script. Please use [examples](./examples/) folder to choose appropriate case:
  1. Full set resources will be created/deployed - [osa_config.tfvars](./examples/osa_config.tfvars).
  2. Custom deployment with provided client's resources (RG, Vnet, Storage Account). Only Virtual appliances will be created - [osa_custom_config.tfvars](./examples/osa_custom_config.tfvars).
  3. Combination two cases above. For instance, from client's side we have only RG and Vnet, so Storage Account and Virtual appliances will be created. Please use template file, remove or uncomment required blocks - [osa_config_tmpl.tfvars](./examples/osa_config_tmpl.tfvars)

---

## Azure Cloud Resources TF Restrictions

1. **[Region](https://docs.imprivata.com/onesign/content/topics/imprivataplatform/appliance/virtualappliances/azuredeployg4.html#Deploy_G4_Appliance_On_Azure)**: `East US`, `Central US`, `West US`, `North Central US`.
2. **[VM Appliance size](https://docs.imprivata.com/onesign/content/topics/imprivataplatform/appliance/virtualappliances/azuredeployg4.html#Deploy_G4_Appliance_On_Azure)**: `Standard_F4s_v2`, `Standard_F8s_v2`.
3. **Number of VM appliances**: <= 10.

---

## Terraform namegenerator properties restrictions

1. **project_name**: <= 7 characters. e.g. Imprivata - `imp`.
2. **workload_name**: <= 3 characters. e.g. OneSign Appliances - `osa`.
3. **env_name**: <= 4 characters, e.g. `dev`, `test`, `prod`.

Examples:
`rg-imp-osa-dev-use-01`, `vm-imp-osa-dev-use-01`

---

## What the Script Does

1. **Checks for Terraform CLI**
   Exits with an error if Terraform is not installed.

2. **Initializes Terraform**
   Runs `terraform init` in the specified directory to initialize the working directory.

3. **Validates Terraform Configuration**
   Runs `terraform validate` to ensure the configuration is syntactically valid.

4. **Creates a Terraform Plan**
   Runs `terraform plan` with the specified variable file and outputs the plan to the specified plan file.

5. **Prompts for Confirmation**
   Unless `-AutoApprove` is set, prompts the user to confirm before applying the plan.

6. **Applies the Terraform Plan**
   Runs `terraform apply` using the generated plan file, with auto-approval and parallelism set to 10.

7. **Logs Progress**
   Outputs timestamped log messages at each step.

---

## Usage Examples

### Basic Usage

```powershell
.\deployOSA.ps1
```

### Specify a Different Terraform Directory and Variable File

```powershell
.\deployOSA.ps1 -TerraformDir "framework" -ConfigFile "../osa_config.tfvars"
```

### Auto-Approve Apply Step (No Confirmation Prompt)

```powershell
.\deployOSA.ps1 -AutoApprove
```

### Full Example with All Parameters

```powershell
.\deployOSA.ps1 -TerraformDir "framework" -PlanFile "myplan" -ConfigFile "../myvars.tfvars" -AutoApprove
```

---

## Notes

- If you do not specify `-AutoApprove`, you will be prompted to confirm before the apply step.
- The script will stop and display an error if any step fails.
- All actions are logged with timestamps for traceability.

---

## Troubleshooting

- **Terraform Not Found:**
  Ensure Terraform CLI is installed and added to your system's PATH.

- **Permission Issues:**
  Run PowerShell as Administrator if you encounter permission errors.

- **Terraform Errors:**
  Review the log output for details on any errors during initialization, validation, planning, or applying.
