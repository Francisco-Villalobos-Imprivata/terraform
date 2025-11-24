resource "google_compute_firewall" "rules" {
  for_each    = { for r in var.rules : r.name => r }
  project     = var.project_id
  name        = var.suffix_name != null ? format("%s-%s", each.value.name, var.suffix_name) : each.value.name
  network     = var.network
  description = each.value.description

  source_ranges           = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges      = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags             = each.value.source_tags
  source_service_accounts = each.value.source_service_accounts
  target_tags             = each.value.target_tags
  target_service_accounts = each.value.target_service_accounts
  priority                = each.value.priority

  dynamic "log_config" {
    for_each = each.value.log_config != null ? [each.value.log_config] : []
    content {
      metadata = log_config.value.metadata
    }
  }

  dynamic "allow" {
    for_each = each.value.allow != null ? each.value.allow : []
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = each.value.deny != null ? each.value.deny : []
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}