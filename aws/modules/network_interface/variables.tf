variable "machine_prefix" {
  type = string
}

variable "instance_indexes" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_allow_cidrs" {
  type = list(string)
}

variable "security_group_allow_ports" {
  type = list(object({
    port        = number
    description = optional(string)
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
