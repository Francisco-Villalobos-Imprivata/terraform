output "Cloud_NAT_IP" {
  description = "The external IP address reserved and used by Cloud NAT"
  value = { for k, v in module.nat : k => v }
}

output "NETWORK_PARAMS" {
  value       = try(module.vpc, null)
  description = "Network parameters created with VPC module"
}

output "INSTANCE_PARAMS" {
  value = {
    for k, inst in module.instance : k => {
      instance_name      = inst.vm_name
      instance_ip        = inst.vm_ip
      console_connection = "gcloud compute connect-to-serial-port --project=${var.project_id} ${inst.vm_name} --zone ${var.zone} --port=1"
      port_forward       = "gcloud compute start-iap-tunnel --zone ${var.zone} ${inst.vm_name} 81 --project ${var.project_id} --local-host-port=localhost:81"
    }
  }
  description = "A map of instance names to their IPs."
}