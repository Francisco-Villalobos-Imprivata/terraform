data "aws_region" "current" {}

locals {
  appliance_type_map = {
    service  = "c5.xlarge"  # 4vCPU/8GB RAM  - to match F4s_v2
    database = "c5.2xlarge" # 8vCPU/16GB RAM - to match F8s_v2
  }
  default_indexes = [for i in range(1, 11) : format("%02d", i)]
  appliances_expanded = flatten([
    for app in var.appliances : [
      for idx, instance_index in(
        length(app.indexes) > 0 ?
        app.indexes :
        slice(local.default_indexes, 0, app.count)
        ) : {
        instance_index = instance_index
        instance_type  = local.appliance_type_map[app.type]
      }
    ]
  ])
  region_image_map = {
    us-east-1      = "ami-0be9a2db68f81cd1b"
    eu-west-2      = "ami-11111111111111111"
    ap-southeast-2 = "ami-11111111111111111"
  }
}

variable "machine_prefix" {
  type    = string
  default = "OSA"
}

variable "image_id" {
  type    = string
  default = "ami-0be9a2db68f81cd1b"
}

variable "appliances" {
  description = "Number of EAM appliances per type (database, service), with optional explicit indexes"
  type = list(object({
    type    = string
    count   = number
    indexes = optional(list(string), [])
  }))
  default = [{
    type  = "service"
    count = 1
  }]
}

variable "disk_iops_override" {
  type    = number
  default = null
}

variable "subnet_id" {
  type    = string
  default = "subnet-05033923cfaef87e8"
  #default = null
}

variable "vpc_cidr" {
  type    = string
  default = null
}

variable "subnet_cidrs" {
  type    = list(string)
  default = null
}

variable "security_group_allow_cidrs" {
  type    = list(string)
  default = ["109.87.153.38/32"] # EU Imprivata VPN CIDR, TODO: drop after testing
  #default = ["0.0.0.0/0"]
}

variable "security_group_allow_ports" {
  type = list(object({
    port        = number
    description = optional(string)
  }))
  default = [
    { port = 22, description = "SSH" },
    { port = 81, description = "HTTP" },
    { port = 443, description = "HTTPS" },
    { port = 1521, description = "DB" },
  ]
}

variable "tags" {
  type    = map(string)
  default = {}
}
