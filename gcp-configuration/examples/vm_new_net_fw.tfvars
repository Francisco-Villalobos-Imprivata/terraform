project_id = "my-gcp-project"
region     = "us-central1"
zone       = "us-central1-a"

instances = {
  app = {
    instance_name = "app-server"
    instance_type = "e2-highmem-4"
  }
}

deploy_network = {
  enable        = true
  ip_cidr_range = "10.40.0.0/16"
}

enable_firewall = ["custom"]

firewal_rules = [
  {
    name        = "allow-ssh"
    description = "Allow SSH from anywhere"
    direction   = "INGRESS"
    ranges      = ["0.0.0.0/0"]
    allow = [{
      protocol = "tcp"
      ports    = ["22"]
    }]
  },
  {
    name        = "allow-http"
    description = "Allow HTTP traffic"
    direction   = "INGRESS"
    ranges      = ["0.0.0.0/0"]
    allow = [{
      protocol = "tcp"
      ports    = ["80"]
    }]
  }
]