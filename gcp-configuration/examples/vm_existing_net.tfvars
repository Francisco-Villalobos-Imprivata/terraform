
project_id = "my-gcp-project"
region     = "us-central1"
zone       = "us-central1-a"

instances = {
  vm1 = {
    instance_name = "imprivata-vm1"
    instance_type = "e2-medium"
  }
  vm2 = {
    instance_name = "imprivata-vm2"
    instance_type = "e2-standard-2"
  }
}

deploy_network = {
  enable = false
}

network_interface = [
  {
    network        = "default"
    subnetwork     = "default"
    subnet_project = "my-gcp-project"
    static_ip      = null
    access_config = {
      nat_ip = null
      tier   = "PREMIUM"
    }
    alias_ip_ranges = []
    stack_type      = "IPV4_ONLY"
  }
]