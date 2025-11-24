# https://registry.terraform.io/providers/hashicorp/azurerm/4.41.0/docs/resources/network_interface
resource "azurerm_network_interface" "main" {
  name                = format("%s-nic", var.name)
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = var.vm_network_interface.ip_configuration.name
    subnet_id                     = var.vm_network_interface.ip_configuration.subnet_id
    private_ip_address_allocation = var.vm_network_interface.ip_configuration.private_ip_address_allocation
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/4.41.0/docs/resources/network_interface_security_group_association
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = var.vm_network_interface.nic_nsg_id
}
