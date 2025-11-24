resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_compute_network" "vpc_network" {
  provider                        = google-beta
  project                         = var.project_id
  name                            = coalesce(var.vpc_name, format("vpc-imprivata-%s", random_string.suffix.id))
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
  description                     = var.description
  delete_default_routes_on_create = var.delete_default_internet_gateway_routes
}

resource "google_compute_subnetwork" "vpc_subnet" {
  provider                 = google-beta
  project                  = var.project_id
  region                   = var.region
  name                     = var.vpc_name != null ? format("%s-%s", var.vpc_name, var.region) : format("imprivata-%s-%s", var.region, random_string.suffix.id)
  ip_cidr_range            = var.ip_cidr_range
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = var.google_api_access
  purpose                  = var.purpose

  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges != [] ? { for range in var.secondary_ranges : range.range_name => range } : {}

    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

}
