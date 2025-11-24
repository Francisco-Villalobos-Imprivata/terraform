locals {
  subnet_count = length(var.subnet_cidrs)
  azs          = slice(data.aws_availability_zones.available.names, 0, local.subnet_count)
  subnets = {
    for idx, az in local.azs :
    idx => {
      az   = az
      cidr = var.subnet_cidrs[idx]
    }
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.tags
}

resource "aws_subnet" "isolated_subnet" {
  for_each = local.subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false
  tags                    = var.tags
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.tags
}

resource "aws_route_table_association" "rtb_association" {
  for_each = aws_subnet.isolated_subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.route_table.id
}
