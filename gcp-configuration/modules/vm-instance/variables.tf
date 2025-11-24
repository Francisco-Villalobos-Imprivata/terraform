variable "project_id" {
  description = "The ID of the project in which the resource belongs"
  type        = string
}

variable "instance_name" {
  description = "A unique name for the VM"
  type        = string
}

variable "deploy_network" {
  description = "When enabled, the parameter will create a static IP address for the VM"
  type        = bool
}

variable "network_interface" {
  description = <<EOT
    List of network interface configurations for the VM(s).
    Each object must specify either a `network` or `subnetwork` to attach the interface.
    - `network` (string, optional): Name or self_link of the VPC network.
    - `subnetwork` (string, optional): Name or self_link of the subnetwork.
    - `subnet_project` (string, optional): Project ID if the subnetwork is in a Shared VPC host project.
    - `stack_type` (string, optional): Stack type for the NIC. Default is "IPV4_ONLY". Use "IPV4_IPV6" if dual stack is required.
    - `access_config` (object, optional): Defines external IP (public) config:
      - `nat_ip` (string, optional): Reserved static external IP. Omit for ephemeral.
      - `tier` (string, optional): Network service tier ("PREMIUM" or "STANDARD").
    - `static_ip` (string, optional): Internal (private) static IP to assign.
    - `alias_ip_ranges` (list(object), optional): Alias IPs to assign for secondary ranges:
      - `ip_range` (string): CIDR block or specific IP.
      - `name_range` (string): Name of the secondary range in the subnetwork.
  EOT
  type = list(object({
    network        = optional(string)
    subnetwork     = optional(string)
    subnet_project = optional(string)
    stack_type     = optional(string, "IPV4_ONLY")
    access_config = optional(object({
      nat_ip = optional(string)
      tier   = optional(string)
    }), null)
    static_ip = optional(string)
    alias_ip_ranges = optional(list(object({
      ip_range   = string
      name_range = string
    })))
  }))
  default = []
  validation {
    condition = alltrue([
      for nic in var.network_interface :
      (try(nic.network, null) != null) || (try(nic.subnetwork, null) != null)
    ])
    error_message = "Each network_interface must define either `network` or `subnetwork`."
  }
}

variable "hostname" {
  description = "A custom hostname for the instance."
  type        = string
  default     = ""
}

variable "zone" {
  description = "The zone that the machine should be created in."
  validation {
    condition     = contains(["us-central1", "us-east1", "us-east4", "us-east5", "us-south1", "us-west1", "us-west2", "us-west3", "us-west4"], substr(var.zone, 0, length(var.zone) - 2))
    error_message = "Incorrect zone. It must exist in one of the following regions: \"us-central1\", \"us-east1\", \"us-east4\", \"us-east5\", \"us-south1\", \"us-west1\", \"us-west2\", \"us-west3\", \"us-west4\"."
  }
}

variable "instance_type" {
  description = "The machine type to create. Use one from: e2-standard-(2/4/8), n2-standard-(2/4/8)"
  validation {
    condition     = can(regex("^(e2|n2)-standard-(2|4|8)$", var.instance_type))
    error_message = "Incorrect machine type. Use next types: \"e2-standard-(2/4/8)\", \"n2-standard-(2/4/8)\"."
  }
}

variable "image" {
  description = "The image name provided by Imprivata."
}

variable "project_image" {
  description = "The name of the project where image is located."
  type        = string
}

variable "labels" {
  description = "A set of key/value label pairs assigned to the instance."
  default     = {}
}

variable "deletion_protection" {
  description = "Enable deletion protection on this instance"
  type        = bool
  default     = true
}

variable "firewall_tags" {
  description = "A list of network tags to attach to the instance."
  default     = []
}

variable "vm_disk_size" {
  description = "The size of the image in gigabytes."
  default     = 300
}

variable "attached_disk" {
  description = <<EOT
    List of existing persistent disks to attach to the VM instance.
    Each object represents one disk:
    - `source` (string, required): The full self_link of the disk to attach.
    - `device_name` (string, required): The name by which the disk is exposed to the guest OS.
    - `mode` (string, optional): The access mode. Default is "READ_WRITE".
        Allowed values:
      - "READ_WRITE": The disk is attached in read/write mode (default).
      - "READ_ONLY" : The disk is attached in read-only mode.
  EOT
  type = list(object({
    source      = string
    device_name = string
    mode        = optional(string, "READ_WRITE")
  }))
  default = []
}

variable "metadata" {
  description = <<EOT
    Metadata key/value pairs to make available from within the instance"
    More info: https://cloud.google.com/compute/docs/metadata/predefined-metadata-keys
  EOT
  default = {
    enable-oslogin     = "TRUE"
    serial-port-enable = "TRUE"
  }
}

variable "service_account" {
  description = "The service account e-mail address."
  default     = null
}

variable "scopes" {
  description = <<EOT
    List of OAuth 2.0 scopes to assign to the VM's service account.
    Scopes control what Google Cloud APIs the instance can access.
  EOT
  type        = list(string)
  default     = ["cloud-platform"]
}