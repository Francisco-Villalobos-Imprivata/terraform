variable "machine_prefix" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
