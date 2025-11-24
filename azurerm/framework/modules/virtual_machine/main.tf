# https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key.html
resource "tls_private_key" "ssh" {
  count = var.disable_password_authentication ? 1 : 0

  algorithm = var.vm_ssh_tls_private_key.algorithm
  rsa_bits  = var.vm_ssh_tls_private_key.rsa_bits
}

resource "random_password" "vm_admin_password" {
  count = var.disable_password_authentication ? 0 : 1

  length           = 20
  lower            = true
  upper            = true
  special          = true
  override_special = "!*#?"
  min_lower        = 1
  min_upper        = 1
  min_special      = 1
}

# https://registry.terraform.io/providers/hashicorp/azurerm/4.41.0/docs/resources/linux_virtual_machine
resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.name
  admin_username                  = var.admin_username
  admin_password                  = var.disable_password_authentication ? null : sensitive(random_password.vm_admin_password[0].result)
  location                        = var.location
  network_interface_ids           = [azurerm_network_interface.main.id]
  resource_group_name             = var.resource_group_name
  size                            = var.size
  availability_set_id             = var.availability_set_id
  disable_password_authentication = var.disable_password_authentication
  tags                            = var.tags

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = sensitive(tls_private_key.ssh[0].public_key_openssh)
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_uri != null ? [1] : []
    content {
      storage_account_uri = var.boot_diagnostics_storage_uri
    }
  }

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  plan {
    name      = var.source_image_reference.sku
    product   = var.source_image_reference.offer
    publisher = var.source_image_reference.publisher
  }
}
