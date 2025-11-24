# https://registry.terraform.io/providers/hashicorp/azurerm/4.41.0/docs/resources/availability_set
resource "azurerm_availability_set" "main" {
  name                         = var.aset_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  platform_update_domain_count = var.aset.platform_update_domain_count
  platform_fault_domain_count  = var.aset.platform_fault_domain_count
  proximity_placement_group_id = var.aset.proximity_placement_group_id
  managed                      = var.aset.managed
  tags                         = var.tags
}
