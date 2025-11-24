# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
resource "azurerm_virtual_network" "main" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name              = subnet.value.name
      address_prefixes  = subnet.value.address_prefixes
      security_group    = subnet.value.security_group
      service_endpoints = subnet.value.service_endpoints
    }
  }

  tags = var.tags
}
