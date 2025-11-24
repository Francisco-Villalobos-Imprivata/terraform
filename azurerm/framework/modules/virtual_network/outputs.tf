output "id" {
  value       = azurerm_virtual_network.main.id
  description = "The Virtual Network ID."
}

output "subnets" {
  value = {
    for k, v in azurerm_virtual_network.main.subnet :
    v.name => v
  }
  description = "One or more subnet IDs."
}
