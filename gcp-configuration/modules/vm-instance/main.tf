resource "google_compute_instance" "imprivata" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone
  project      = var.project_id
  tags         = var.firewall_tags

  deletion_protection       = var.deletion_protection
  hostname                  = var.hostname == "" ? format("%s.local", var.instance_name) : var.hostname
  allow_stopping_for_update = true

  labels = var.labels

  boot_disk {
    device_name = var.instance_name
    initialize_params {
      image = data.google_compute_image.imprivata_image.self_link
      size  = var.vm_disk_size
      type  = "pd-ssd"
    }
  }

  dynamic "attached_disk" {
    for_each = var.attached_disk
    content {
      source      = attached_disk.value.source
      device_name = attached_disk.value.device_name
      mode        = attached_disk.value.source
    }
  }

  metadata = var.metadata

  dynamic "network_interface" {
    for_each = var.network_interface

    content {
      network            = network_interface.value.network
      subnetwork         = network_interface.value.subnetwork
      subnetwork_project = network_interface.value.subnet_project
      network_ip         = try(coalesce(network_interface.value.static_ip, google_compute_address.static[network_interface.value.subnetwork].address), null)

      dynamic "access_config" {
        for_each = network_interface.value.access_config != null ? [network_interface.value.access_config] : []
        content {
          nat_ip       = access_config.value.nat_ip
          network_tier = access_config.value.tier
        }
      }

      dynamic "alias_ip_range" {
        for_each = network_interface.value.alias_ip_ranges != null ? network_interface.value.alias_ip_ranges : []
        content {
          ip_cidr_range         = alias_ip_range.value.ip_cidr_range
          subnetwork_range_name = alias_ip_range.value.subnetwork_range_name
        }
      }

      stack_type = network_interface.value.stack_type
    }
  }


  service_account {
    email  = var.service_account # null create or provided
    scopes = var.scopes
  }

}
resource "google_compute_address" "static" {
  for_each = var.deploy_network ? {} : {
    for k in var.network_interface : k.subnetwork => k if k.subnetwork != null
  }
  project      = var.project_id
  name         = format("%s-internal-address", var.instance_name)
  subnetwork   = each.value.subnetwork
  address_type = "INTERNAL"
  region       = replace(var.zone, "/-.$/", "")
}

data "google_compute_image" "imprivata_image" {
  name    = var.image
  project = var.project_image
}