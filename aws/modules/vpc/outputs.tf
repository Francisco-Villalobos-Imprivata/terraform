output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = [for s in aws_subnet.isolated_subnet : s.id]
}
