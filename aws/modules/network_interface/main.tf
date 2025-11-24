locals {
  cidr_port_map = {
    for pair in flatten([
      for cidr in var.security_group_allow_cidrs : [
        for port_obj in var.security_group_allow_ports : {
          key = "${cidr}-${port_obj.port}"
          value = {
            cidr        = cidr
            port        = port_obj.port
            description = lookup(port_obj, "description", null)
          }
        }
      ]
    ]) : pair.key => pair.value
  }
}

resource "aws_security_group" "security_group" {
  name   = lower("${var.machine_prefix}-security-group")
  vpc_id = var.vpc_id
  tags   = var.tags
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each = local.cidr_port_map

  security_group_id = aws_security_group.security_group.id

  description = each.value.description == "" ? each.value.description : "Allow ${each.value.port} access"
  cidr_ipv4   = each.value.cidr
  from_port   = each.value.port
  ip_protocol = "tcp"
  to_port     = each.value.port
}

resource "aws_network_interface" "network_interface" {
  count = length(var.instance_indexes)
  # Spread the ENIs/EC2s between subnets
  subnet_id       = var.subnet_ids[count.index % length(var.subnet_ids)]
  security_groups = [aws_security_group.security_group.id]
  tags = merge({
    Name = lower("${var.machine_prefix}-${var.instance_indexes[count.index]}-eni")
    },
    var.tags
  )
}
