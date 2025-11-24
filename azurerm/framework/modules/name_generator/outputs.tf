output "resource_name" {
  value       = local.resource_name
  description = "The generated name of the Resource according to the name convention."
  precondition {
    condition = (
      contains(["MicrosoftStorage/storageAccounts", "MicrosoftKeyVault/vaults"], var.resource_type) ?
      length(local.resource_name) <= 24
      : length(local.resource_name) <= 30
    )
    error_message = "Length of the resource name \"${local.resource_name}\" more than 24(30) symbols, please make it shorter."
  }
}
