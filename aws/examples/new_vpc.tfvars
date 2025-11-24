machine_prefix = "osa"
image_id       = "ami-0be9a2db68f81cd1b"
appliances = [
  {
    type  = "service"
    count = 2
  },
]
disk_iops_override         = null
vpc_cidr                   = "10.10.0.0/24"
subnet_cidrs               = ["10.10.0.0/25", "10.10.0.128/25"]
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
tags = {}
