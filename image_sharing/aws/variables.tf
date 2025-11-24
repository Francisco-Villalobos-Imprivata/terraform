locals {
  region_ami_map = {
    us-east-1      = "ami-0be9a2db68f81cd1b"
    eu-west-2      = "ami-11111111111111111"
    ap-southeast-2 = "ami-11111111111111111"
  }
  region_provider_map = {
    "us-east-1"      = aws.us-east-1
    "eu-west-2"      = aws.us-west-2
    "ap-southeast-2" = aws.ap-southeast-2
  }
}

variable "customer_accounts" {
  type = list(object({
    customer   = string
    account_id = string
    regions    = list(string)
  }))
  default = []
}
