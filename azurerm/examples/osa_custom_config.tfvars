# Custom configuration of OneSign Appliances deployment in Azure.
# It uses existing resources: Resource Group, Virtual Network, and Storage Account.
# And create only VMs.

azure_subscription_id = "c3217123-3040-49c1-bacd-460ac7518c91"
location              = "East US" # Azure region. Please use one of: East US, Central US, North Central US.
project_name          = "imp"     # <= 7 characters. e.g. Imprivata - "imp"
workload_name         = "osa"     # <= 3 characters. e.g. OneSign Appliances - "osa"
env_name              = "qa"      # <= 4 characters, e.g. dev, test, prod
tags                  = {}        # Optional tags for all resources: e.g. { CostCenter = "1111" }

# Custom Azure Cloud configurations where client has existing resources:
# Resource Group and/or Virtual Network and/or Storage Account.
custom_resource_group_name = "rg-imp-osa-qa-use-01"
custom_virtual_network = {
  name                = "Imprivata-Azure-QE"
  resource_group_name = "RG-QE-Networking"
  subnet_name         = "SNet-QE"
}
custom_storage_account = {
  name                = "stimposaqause01"
  resource_group_name = "rg-imp-osa-qa-use-01"
}

# Azure Marketplace OneSign VHD image offer details.
onesign_vhd_offer = {
  publisher = "imprivatainc1580479939967"
  offer_id  = "onesign_vhd"
  plan_id   = "onesign_25-4-99_g5_plan1"
  version   = "latest"
}

# OneSign Appliance VM instances configuration.
# Please use no more than 10 instances.
virtual_appliances = [
  {
    instance = 1                 # Appliance instance number: <= 10.
    size     = "Standard_F4s_v2" # VM size. Possible values: Standard_F4s_v2 or Standard_F8s_v2
  },
  {
    instance = 2
    size     = "Standard_F8s_v2"
  }
]
