output "aset_name" {
  value       = azurerm_availability_set.main.name
  description = "The Name of the Availability Set."
}

output "aset_id" {
  value       = azurerm_availability_set.main.id
  description = "The Name of the Availability Set."
}

output "nic_nsg_id" {
  value       = azurerm_network_security_group.main.id
  description = "The ID of the VM NIC Network Security Group."
}
