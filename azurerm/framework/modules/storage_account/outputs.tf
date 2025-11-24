output "id" {
  value       = azurerm_storage_account.main.id
  description = "The ID of the Storage Account."
}

output "name" {
  value       = azurerm_storage_account.main.name
  description = "The Name of the Storage Account."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.main.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "secondary_blob_endpoint" {
  value       = azurerm_storage_account.main.secondary_blob_endpoint
  description = "The endpoint URL for blob storage in the secondary location."
}
