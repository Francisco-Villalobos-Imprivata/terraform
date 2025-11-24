output "name" {
  value       = azurerm_linux_virtual_machine.main.name
  description = "The Name of the Virtual Machine."
}

output "private_ip_address" {
  value       = azurerm_linux_virtual_machine.main.private_ip_address
  description = "The Private IP Address of the Virtual Machine."
}
