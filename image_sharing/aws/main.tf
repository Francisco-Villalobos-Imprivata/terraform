# Share images with specified AWS accounts in corresponding regions
resource "aws_ami_launch_permission" "ami_share" {
  for_each = {
    for entry in flatten([
      for customer in var.customer_accounts : [
        for region in customer.regions : {
          key        = "${customer.customer}-${customer.account_id}-${region}"
          customer   = customer.customer
          account_id = customer.account_id
          region     = region
          ami_id     = lookup(local.region_ami_map, region, null)
        }
        if contains(keys(local.region_ami_map), region)
      ]
    ]) : entry.key => entry
  }

  # Select provider based on region
  provider = local.region_provider_map[each.value.region]

  image_id   = each.value.ami_id
  account_id = each.value.account_id
}
