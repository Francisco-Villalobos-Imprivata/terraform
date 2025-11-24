variable "vpc_cidr" {
  type = string
}

variable "subnet_cidrs" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
