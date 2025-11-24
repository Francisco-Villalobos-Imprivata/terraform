output "nat-ip" {
  value = google_compute_address.external_address.address
}