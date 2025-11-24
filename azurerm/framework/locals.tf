data "azurerm_storage_account" "custom" {
  count = var.custom_storage_account != null ? 1 : 0

  name                = var.custom_storage_account.name
  resource_group_name = var.custom_storage_account.resource_group_name
}

data "azurerm_subnet" "custom" {
  count = var.custom_virtual_network != null ? 1 : 0

  name                 = var.custom_virtual_network.subnet_name
  virtual_network_name = var.custom_virtual_network.name
  resource_group_name  = var.custom_virtual_network.resource_group_name
}

locals {
  resource_group_name = coalesce(var.custom_resource_group_name, try(module.resource_group[0].name, null))
  subnet_id           = coalesce(try(module.virtual_network[0].subnets[var.vm_nic_subnet_name].id, null), local.custom_subnet_id)

  custom_subnet_id             = try(data.azurerm_subnet.custom[0].id, null)
  custom_primary_blob_endpoint = try(data.azurerm_storage_account.custom[0].primary_blob_endpoint, null)

  virtual_appliances = {
    for k, v in var.virtual_appliances :
    v.instance => v
  }

  default_tags = {
    env        = lower(var.env_name)
    project    = lower(var.project_name)
    workload   = lower(var.workload_name)
    deployedby = "terraform"
  }
  tags = merge(local.default_tags, var.tags)

  default_vm_configuration = {
    disable_password_authentication = false
    admin_username                  = "vmadmin"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Premium_LRS"
    }
    source_image_reference = {
      publisher = var.onesign_vhd_offer.publisher
      offer     = var.onesign_vhd_offer.offer_id
      sku       = var.onesign_vhd_offer.plan_id
      version   = var.onesign_vhd_offer.version
    }
  }

  default_nic_nsg = {
    security_rules = [
      {
        name                       = "HTTPS"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        priority                   = 320
        direction                  = "Inbound"
      },
      {
        name                       = "HTTP"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Deny"
        priority                   = 340
        direction                  = "Inbound"
      },
      {
        name                       = "Port_81"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "81"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        priority                   = 360
        direction                  = "Inbound"
      },
      {
        name                       = "Port_22"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        priority                   = 380
        direction                  = "Inbound"
      },
      {
        name                       = "Port_1521"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "1521"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        access                     = "Allow"
        priority                   = 390
        direction                  = "Inbound"
      }

    ]
  }

}
