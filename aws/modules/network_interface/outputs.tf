output "network_interface_ids" {
  value = aws_network_interface.network_interface[*].id
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}

output "security_group_name" {
  value = aws_security_group.security_group.name
}

output "security_group_rules" {
  value = local.cidr_port_map
}
