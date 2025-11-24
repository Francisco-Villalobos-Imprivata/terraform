machine_prefix = "osa"
image_id       = "ami-0be9a2db68f81cd1b"
appliances = [
  {
    type  = "database" # c5.2xlarge
    count = 1
  },
  {
    type    = "service" # c5.xlarge
    count   = 2
    indexes = ["03", "04"] # optional override
  }
]
disk_iops_override         = null
subnet_id                  = "subnet-05033923cfaef87e8"
security_group_allow_cidrs = ["0.0.0.0/0"]
security_group_allow_ports = [{
  port        = 22
  description = "SSH"
  },
  {
    port        = 81
    description = "HTTP"
  },
  {
    port        = 443
    description = "HTTPS"
  },
  {
    port        = 1521
    description = "DB"
  },
]
