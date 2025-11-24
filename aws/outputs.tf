output "ec2_instance_profile" {
  value = module.iam.ec2_instance_profile_name
}

output "security_group_id" {
  value = module.network_interface.security_group_id
}

output "security_group_name" {
  value = module.network_interface.security_group_name
}

output "security_group_rules" {
  value = module.network_interface.security_group_rules
}

output "appliances" {
  value = module.compute.instances
}
