output "ami_sharing_details" {
  value = [
    for key, perm in aws_ami_launch_permission.ami_share : {
      customer   = [for c in var.customer_accounts : c.customer if c.account_id == perm.account_id][0]
      account_id = perm.account_id
      region     = split(".", perm.provider)[1]
      ami_id     = perm.image_id
    }
  ]
}
