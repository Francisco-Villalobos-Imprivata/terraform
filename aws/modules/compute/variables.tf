variable "machine_prefix" {
  type = string
}

variable "image_id" {
  type = string
}

variable "appliances" {
  type = list(object({
    instance_index = string
    instance_type  = string
  }))
}

variable "disk_iops_override" {
  type    = number
  default = null
}

variable "network_interface_ids" {
  type = list(string)
}

variable "ec2_instance_profile_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
