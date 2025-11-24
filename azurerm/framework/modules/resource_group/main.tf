# https://registry.terraform.io/providers/hashicorp/4.41.0/latest/docs/resources/resource_group
resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
