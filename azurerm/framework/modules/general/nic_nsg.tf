# https://registry.terraform.io/providers/hashicorp/azurerm/4.41.0/docs/resources/network_security_group
resource "azurerm_network_security_group" "main" {
  name                = var.nic_nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.nic_nsg.security_rules
    content {
      name                       = security_rule.value.name
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
    }
  }
  tags = var.tags
}
