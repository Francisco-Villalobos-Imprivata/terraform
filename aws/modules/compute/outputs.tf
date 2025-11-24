output "instances" {
  value = [
    for instance in aws_instance.appliance : {
      name        = instance.tags["Name"]
      instance_id = instance.id
      type        = instance.instance_type
      private_ip  = instance.private_ip
      ami         = instance.ami
    }
  ]
}
