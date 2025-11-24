output "resource_group_name" {
  value       = local.resource_group_name
  description = "Resource Group Name where all resources are deployed."
}

output "virtual_appliances" {
  value = {
    for k, v in module.virtual_appliance : k => {
      name               = v.name
      private_ip_address = v.private_ip_address
    }
  }
  description = "Attributes of the Virtual Appliances."
}
