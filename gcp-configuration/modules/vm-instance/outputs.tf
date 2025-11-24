output "vm_ip" {
  description = "The internal (private) IPv4 address assigned to the Compute Engine instance."
  value       = google_compute_instance.imprivata.network_interface[0].network_ip
}

output "vm_name" {
  description = "The name created to the Compute Engine instance."
  value       = google_compute_instance.imprivata.name
}