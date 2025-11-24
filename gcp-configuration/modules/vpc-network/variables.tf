variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "region" {
  description = "The GCP region for this subnetwork"
  validation {
    condition     = contains(["us-central1", "us-east1", "us-east4", "us-east5", "us-south1", "us-west1", "us-west2", "us-west3", "us-west4"], var.region)
    error_message = "Incorrect region. It must exist in one of the following regions: \"us-central1\", \"us-east1\", \"us-east4\", \"us-east5\", \"us-south1\", \"us-west1\", \"us-west2\", \"us-west3\", \"us-west4\"."
  }
}

variable "ip_cidr_range" {
  description = <<EOF
    The range of internal addresses that are owned by this subnetwork.
    Ranges must be unique and non-overlapping within a network.
  EOF
  type        = string
}

variable "vpc_name" {
  description = "A name for new VPC"
  type        = string
  default     = null
}

variable "description" {
  description = "An optional description of this resource."
  type        = string
  default     = "Default VPC for Imprivata VMs"
}

variable "delete_default_internet_gateway_routes" {
  description = "Default routes (0.0.0.0/0) will be deleted immediately after network creation"
  default     = false
}

variable "google_api_access" {
  description = <<EOF
    When enabled, VMs in this subnetwork without external IP addresses
    can access Google APIs and services by using Private Google Access.
  EOF
  type        = bool
  default     = true
}

variable "purpose" {
  description = <<EOF
    The purpose of the resource.
    This field can be either PRIVATE, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY,
    PRIVATE_SERVICE_CONNECT, PEER_MIGRATION or PRIVATE_NAT
  EOF
  default     = null
}

variable "secondary_ranges" {
  description = <<EOF
    An array of configurations for secondary IP ranges for VM instances contained in this subnetwork.
    The primary IP of such VM must belong to the primary ipCidrRange of the subnetwork.
    The alias IPs may belong to either primary or secondary ranges.
  EOF
  type = list(object({
    range_name    = string,
    ip_cidr_range = string
  }))
  default = []
}
