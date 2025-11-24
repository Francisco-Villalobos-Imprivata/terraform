locals {
  default_networks = var.deploy_network.enable ? [
    {
      subnetwork = module.vpc["custom"].subnet_id
    }
  ] : []

  vm_disk_size = 300

  default_ip_cidr_range = "192.168.10.0/24"

  default_firewall = [
    {
      name      = "allow-iap-ingress"
      direction = "INGRESS"
      ranges    = ["35.235.240.0/20"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22", "80", "81", "443"]
        },
        {
          ports    = []
          protocol = "icmp"
        }
      ]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    },
    {
      name      = "allow-main-ports"
      direction = "INGRESS"
      ranges    = ["0.0.0.0/0"]
      allow = [
        {
          protocol = "tcp"
          ports    = ["22", "80", "81", "443", "1521"]
        },
        {
          ports    = []
          protocol = "icmp"
        }
      ]
      deny = []
      log_config = {
        metadata = "INCLUDE_ALL_METADATA"
      }
    }
  ]
}
