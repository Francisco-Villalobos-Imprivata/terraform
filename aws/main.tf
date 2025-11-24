locals {
  create_vpc     = var.vpc_cidr != null && var.subnet_cidrs != null
  current_region = data.aws_region.current.region
}

data "aws_subnet" "subnet" {
  count = local.create_vpc ? 0 : 1
  id    = var.subnet_id
}

module "iam" {
  source = "./modules/identityaccess"

  machine_prefix = var.machine_prefix
  tags           = var.tags
}

module "vpc" {
  source = "./modules/vpc"
  count  = local.create_vpc ? 1 : 0

  vpc_cidr     = var.vpc_cidr
  subnet_cidrs = var.subnet_cidrs
  tags         = var.tags
}

module "network_interface" {
  source = "./modules/network_interface"

  machine_prefix             = var.machine_prefix
  instance_indexes           = [for eam in local.appliances_expanded : eam.instance_index]
  vpc_id                     = local.create_vpc ? module.vpc.vpc_id : data.aws_subnet.subnet[0].vpc_id
  subnet_ids                 = local.create_vpc ? [module.vpc.subnet_ids] : [var.subnet_id]
  security_group_allow_cidrs = var.security_group_allow_cidrs
  security_group_allow_ports = var.security_group_allow_ports
  tags                       = var.tags
}

module "compute" {
  source = "./modules/compute"

  machine_prefix            = var.machine_prefix
  image_id                  = var.image_id
  appliances                = local.appliances_expanded
  disk_iops_override        = var.disk_iops_override
  network_interface_ids     = module.network_interface.network_interface_ids
  ec2_instance_profile_name = module.iam.ec2_instance_profile_name
  tags                      = var.tags
}
