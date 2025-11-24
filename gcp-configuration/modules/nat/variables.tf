variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "region" {
  description = "The GCP region in which resources (such as the subnetwork and Cloud NAT) will be created."
  type        = string
}

variable "vpc_subnet" {
  description = "The name of the VPC subnetwork to associate with the Cloud NAT configuration."
  type        = string
}

variable "network" {
  description = "The name of the VPC network where the Cloud NAT and router will be deployed."
  type        = string
}

variable "ip_name" {
  description = "The name of the external static IP address used for Cloud NAT."
  type        = string
  default     = "imprivata-nat-ip"
}

variable "router_name" {
  description = "The name of the Cloud Router that manages routes for Cloud NAT."
  type        = string
  default     = "imprivata-nat-router"
}

variable "nat_name" {
  description = "The name of the Cloud NAT resource."
  type        = string
  default     = "imprivata-cloud-nat"
}

variable "nat_ip_allocate_option" {
  description = "Specifies how external IP addresses are allocated for Cloud NAT. Options: 'AUTO_ONLY' or 'MANUAL_ONLY'."
  type        = string
  default     = "MANUAL_ONLY"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  description = "The option to specify which subnetworks should use NAT. Common values: 'ALL_SUBNETWORKS_ALL_IP_RANGES', 'ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES', or 'LIST_OF_SUBNETWORKS'."
  type        = string
  default     = "LIST_OF_SUBNETWORKS"
}

variable "source_ip_ranges_to_nat" {
  description = "The source IP ranges within the subnetwork to be translated by NAT. Example values: 'ALL_IP_RANGES' or 'PRIMARY_IP_RANGE'."
  type        = string
  default     = "ALL_IP_RANGES"
}

variable "log_filter" {
  description = "Specifies the type of logging for Cloud NAT. Options: 'ERRORS_ONLY', 'TRANSLATIONS_ONLY', 'ALL', or 'NONE'."
  type        = string
  default     = "ERRORS_ONLY"
}