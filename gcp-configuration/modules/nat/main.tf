resource "google_compute_address" "external_address" {
  project = var.project_id
  region  = var.region
  name    = var.ip_name
}

resource "google_compute_router" "cloud-nat-router" {
  project = var.project_id
  name    = var.router_name
  region  = var.region
  network = var.network
}

resource "google_compute_router_nat" "cloud-nat" {
  project                            = var.project_id
  name                               = var.nat_name
  router                             = google_compute_router.cloud-nat-router.name
  region                             = google_compute_router.cloud-nat-router.region
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  nat_ips                            = google_compute_address.external_address.*.self_link
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  subnetwork {
    name                    = var.vpc_subnet
    source_ip_ranges_to_nat = [var.source_ip_ranges_to_nat]
  }
  subnetwork {
    name                    = var.vpc_subnet
    source_ip_ranges_to_nat = [var.source_ip_ranges_to_nat]
  }

  log_config {
    enable = true
    filter = var.log_filter
  }
  depends_on = [google_compute_router.cloud-nat-router]
}