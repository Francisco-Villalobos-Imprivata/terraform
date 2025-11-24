# No need to specify `network_interface` if creating VPC, defaults will be used

project_id = "my-gcp-project"
region     = "us-central1"
zone       = "us-central1-a"

instances = {
  main = {
    instance_name = "imprivata-main"
    instance_type = "n2-standard-2"
  }
}

deploy_network = {
  enable        = true
  ip_cidr_range = "10.10.0.0/16"
  secondary_ranges = [
    {
      range_name    = "pods"
      ip_cidr_range = "10.20.0.0/16"
    },
    {
      range_name    = "services"
      ip_cidr_range = "10.30.0.0/16"
    }
  ]
}