# ------------------------
# Required variables
# ------------------------

variable "project_id" {
  description = "The ID of the project in which the resource will be created"
  type        = string
}
variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The zone that the machine should be created in"
  type        = string
}

variable "instances" {
  description = "Map of VM instance definitions."
  type = map(object({
    instance_name = string
    instance_type = string
  }))
}

# ------------------------
# Optional variables
# ------------------------


variable "imprivata_image" {
  description = "Default Imprivata image"
  default     = "eam25-3-0g4build9"
}

variable "imprivata_project_image" {
  description = "Default Imprivata project"
  default     = "sandbox-471714"
}

variable "deploy_network" {
  description = <<EOT
    Configuration for creating a new VPC network (optional).
    - enable = true → create a new VPC network
    - create_nat = (bool, optional) -> Cloud Router and Cloud NAT will be provisioned to provide outbound internet access for instances without external IPs
    - ip_cidr_range (string, optional): Primary CIDR range for subnet
    - secondary_ranges (list, optional): List of secondary IP ranges for the subnet
  EOT
  type = object({
    enable        = bool
    create_nat    = optional(bool)
    ip_cidr_range = optional(string)
    secondary_ranges = optional(list(object({
      range_name    = string,
      ip_cidr_range = string
    })))
  })
  default = {
    enable = false
  }
}

variable "network_interface" {
  description = "List of existing network interface definitions to attach VM(s) to existing VPC/subnet."
  default     = []
}


variable "firewal_rules" {
  description = "Custom firewall rules to apply on the VPC."
  default     = []
}

variable "enable_firewall" {
  description = "List of network names where default firewall rules should be deployed. Empty to skip."
  type        = list(string)
  default     = []
}
