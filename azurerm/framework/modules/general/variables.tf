variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created"
  type        = string
}

variable "aset_name" {
  description = "(Required) The name of the Availability Set. Changing this forces a new resource to be created."
  type        = string
}

variable "nic_nsg_name" {
  description = "(Required) The name of the VM NIC Network Security Group. Changing this forces a new resource to be created."
  type        = string
}

variable "aset" {
  description = <<EOF
  (Required) Availability Set configuration.

  platform_update_domain_count - (Optional) Specifies the number of update domains that are used. Defaults to 5. Changing this forces a new resource to be created.
  platform_fault_domain_count - (Optional) Specifies the number of fault domains that are used. Defaults to 3. Changing this forces a new resource to be created.
  proximity_placement_group_id - (Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created.
  managed - (Optional) Specifies whether the availability set is managed or not. Possible values are true (to specify aligned) or false (to specify classic). Default is true. Changing this forces a new resource to be created.

  EOF
  type = object({
    platform_update_domain_count = optional(number)
    platform_fault_domain_count  = optional(number)
    proximity_placement_group_id = optional(string)
    managed                      = optional(bool)
  })
  default = {
    platform_update_domain_count = 5
    platform_fault_domain_count  = 3
    managed                      = true
  }
}

variable "nic_nsg" {
  description = <<EOF
  (Optional) Network Security Group configuration.
  security_rules - (Optional) One or more `security_rule` blocks as defined below.
    name - (Required) The name of the security rule.
    protocol - (Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all).
    source_port_range - (Optional) Source Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if source_port_ranges is not specified.
    destination_port_range - (Optional) Destination Port or Range. Integer or range between 0 and 65535 or * to match any. This is required if destination_port_ranges is not specified.
    source_address_prefix - (Optional) CIDR or source IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if source_address_prefixes is not specified.
    destination_address_prefix - (Optional) CIDR or destination IP range or * to match any IP. Tags such as VirtualNetwork, AzureLoadBalancer and Internet can also be used. This is required if destination_address_prefixes is not specified.
    access - (Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny.
    priority - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.
    direction - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound.

  EOF
  type = object({
    security_rules = optional(list(object({
      name                       = string
      protocol                   = string
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
      access                     = string
      priority                   = number
      direction                  = string
    })), [])
  })
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource."
  type        = map(any)
  default     = {}
}
