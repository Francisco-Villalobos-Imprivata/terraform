# ========== Azure Resource Group ==========
module "resource_group_name" {
  source = "./modules/name_generator"

  count         = var.custom_resource_group_name == null ? 1 : 0
  location      = var.location
  env_name      = var.env_name
  project_name  = var.project_name
  workload_name = var.workload_name
  resource_type = "MicrosoftResources/resourceGroups"
  instance      = count.index + 1
}

module "resource_group" {
  source = "./modules/resource_group"

  count    = var.custom_resource_group_name == null ? 1 : 0
  name     = module.resource_group_name[0].resource_name
  location = var.location
  tags     = local.tags
}
# ==========================================

# ========== Azure Storage Account ==========
module "storage_account_name" {
  source = "./modules/name_generator"

  count         = var.custom_storage_account == null ? 1 : 0
  location      = var.location
  env_name      = var.env_name
  project_name  = var.project_name
  workload_name = var.workload_name
  resource_type = "MicrosoftStorage/storageAccounts"
  instance      = 1
}

module "storage_account" {
  source = "./modules/storage_account"

  count                    = var.custom_storage_account == null ? 1 : 0
  name                     = module.storage_account_name[0].resource_name
  resource_group_name      = local.resource_group_name
  location                 = var.location
  account_kind             = var.storage_account.account_kind
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
  tags                     = local.tags
}
# ==========================================


# ========== Azure General Resources ==========
module "aset_name" {
  source = "./modules/name_generator"

  location      = var.location
  env_name      = var.env_name
  project_name  = var.project_name
  workload_name = var.workload_name
  resource_type = "MicrosoftCompute/availabilitySets"
  instance      = 1
}

module "nic_nsg_name" {
  source = "./modules/name_generator"

  location      = var.location
  env_name      = var.env_name
  project_name  = var.project_name
  workload_name = var.workload_name
  resource_type = "MicrosoftNetwork/networkSecurityGroups"
  instance      = 1
}

module "general" {
  source = "./modules/general"

  aset_name           = module.aset_name.resource_name
  nic_nsg_name        = module.nic_nsg_name.resource_name
  resource_group_name = local.resource_group_name
  location            = var.location
  nic_nsg             = local.default_nic_nsg
  tags                = local.tags
}
# ==========================================


# ========== Azure Virtual Network ==========
module "virtual_network_name" {
  source = "./modules/name_generator"

  count         = (var.virtual_network != null && var.custom_virtual_network == null) ? 1 : 0
  location      = var.location
  env_name      = var.env_name
  project_name  = var.project_name
  workload_name = var.workload_name
  resource_type = "MicrosoftNetwork/virtualNetworks"
  instance      = count.index + 1
}

module "virtual_network" {
  source = "./modules/virtual_network"

  count               = (var.virtual_network != null && var.custom_virtual_network == null) ? 1 : 0
  name                = module.virtual_network_name[0].resource_name
  resource_group_name = local.resource_group_name
  location            = var.location
  address_space       = var.virtual_network.address_space
  subnets             = var.virtual_network.subnets
  tags                = local.tags
}
# ===========================================


# ========== Azure Virtual Machines ==========
module "virtual_appliance_name" {
  source = "./modules/name_generator"

  for_each      = local.virtual_appliances
  location      = var.location
  env_name      = var.env_name
  project_name  = var.project_name
  workload_name = var.workload_name
  resource_type = "MicrosoftCompute/virtualMachines"
  instance      = each.value.instance
}

module "virtual_appliance" {
  source = "./modules/virtual_machine"

  for_each                        = local.virtual_appliances
  name                            = module.virtual_appliance_name[each.key].resource_name
  admin_username                  = coalesce(each.value.admin_username, local.default_vm_configuration.admin_username)
  location                        = var.location
  resource_group_name             = local.resource_group_name
  size                            = each.value.size
  availability_set_id             = module.general.aset_id
  disable_password_authentication = local.default_vm_configuration.disable_password_authentication
  os_disk                         = coalesce(each.value.os_disk, local.default_vm_configuration.os_disk)
  source_image_reference          = coalesce(each.value.source_image_reference, local.default_vm_configuration.source_image_reference)
  vm_network_interface = {
    nic_nsg_id = module.general.nic_nsg_id
    ip_configuration = {
      subnet_id = local.subnet_id
    }
  }
  boot_diagnostics_storage_uri = coalesce(try(module.storage_account[0].primary_blob_endpoint, null), local.custom_primary_blob_endpoint)
  tags                         = local.tags
}
# ============================================
