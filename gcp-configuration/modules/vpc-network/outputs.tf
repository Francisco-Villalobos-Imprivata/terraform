output "network_id" {
  description = "The unique identifier (ID) of the VPC network resource."
  value       = google_compute_network.vpc_network.id
}

output "net_name" {
  description = "The name of the VPC network."
  value       = google_compute_network.vpc_network.name
}

output "net_self_link" {
  description = "The self-link (fully qualified resource path) of the VPC network."
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_id" {
  description = "The unique identifier (ID) of the subnetwork resource."
  value       = google_compute_subnetwork.vpc_subnet.id
}

output "subnet_self_link" {
  description = "The self-link (fully qualified resource path) of the subnetwork."
  value       = google_compute_subnetwork.vpc_subnet.self_link
}
