module "instance" {
  source              = "./modules/vm-instance"
  for_each            = var.instances
  project_id          = var.project_id
  zone                = var.zone
  image               = var.imprivata_image
  vm_disk_size        = local.vm_disk_size
  project_image       = var.imprivata_project_image
  deletion_protection = false
  deploy_network      = var.deploy_network.enable
  instance_name       = each.value.instance_name
  instance_type       = each.value.instance_type
  network_interface   = length(var.network_interface) > 0 && !var.deploy_network.enable ? var.network_interface : local.default_networks
  depends_on          = [module.vpc]
}

module "vpc" {
  source        = "./modules/vpc-network"
  for_each      = var.deploy_network.enable ? { "custom" = "1" } : {}
  project_id    = var.project_id
  region        = var.region
  ip_cidr_range = coalesce(var.deploy_network.ip_cidr_range, local.default_ip_cidr_range)
}

module "firewall_rules" {
  source   = "./modules/firewall"
  for_each = var.deploy_network.enable ? ["custom"] : (var.enable_firewall != [] ? toset(var.enable_firewall) : [])

  project_id  = var.project_id
  network     = try(module.vpc["custom"].net_name, each.key)
  rules       = concat(var.firewal_rules, local.default_firewall)
  suffix_name = "imprivata"
  depends_on  = [module.vpc]
}

module "nat" {
  for_each   = var.deploy_network.enable && var.deploy_network.create_nat ? { "custom" = "1" } : {}
  source     = "./modules/nat"
  region     = var.region
  project_id = var.project_id
  vpc_subnet = basename(module.vpc["custom"].subnet_id)
  network    = module.vpc["custom"].net_self_link
}

