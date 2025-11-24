param(
    [string]$TerraformDir = "framework",
    [string]$PlanFile     = "tfplan",
    [string]$ConfigFile   = "../osa_config.tfvars",
    [switch]$AutoApprove
)

# Enable strict mode and stop on errors
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

# Logging function
function Write-Log {
    param([string]$Message)
    Write-Host "`n$(Get-Date -Format o):-> $Message" -ForegroundColor Magenta
}

# Check if Terraform is installed
if (-not (Get-Command terraform -ErrorAction SilentlyContinue)) {
    Write-Error (
      "Terraform CLI is not installed or not found in PATH. Please install Terraform and try again." +
      "`nhttps://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli"
    )
    exit 1
}

# Terraform Init
Write-Log "Running 'terraform init'..."
terraform -chdir="$TerraformDir" init `
  -input=false

# Terraform Validate
Write-Log "Running 'terraform validate'..."
terraform -chdir="$TerraformDir" validate

# Terraform Plan
Write-Log "Running 'terraform plan'..."
terraform -chdir="$TerraformDir" plan `
  -input=false `
  -out="$PlanFile" `
  -var-file="$ConfigFile"
  # -detailed-exitcode

# Confirm before apply unless AutoApprove is set
if (-not $AutoApprove) {
    $confirmation = Read-Host "`nDo you want to apply the Terraform plan? (y/n)"
    if ($confirmation -ne "y") {
        Write-Log "Terraform apply cancelled by user."
        exit 0
    }
}

# Terraform Apply
Write-Log "Running 'terraform apply'..."
terraform -chdir="$TerraformDir" apply `
  -auto-approve `
  -parallelism=10 `
  -input=false `
  "$PlanFile"

Write-Log "Terraform deployment completed successfully."
