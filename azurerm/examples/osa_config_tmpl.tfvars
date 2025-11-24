# Template variables for OneSign Appliances deployment in Azure.
# Please use it for different scenarios.
#

azure_subscription_id = "c3217123-3040-49c1-bacd-460ac7518c91"
location              = "West US" # Azure region. Please use one of: East US, Central US, North Central US.
project_name          = "imp"     # <= 7 characters. e.g. Imprivata - "imp"
workload_name         = "osa"     # <= 3 characters. e.g. OneSign Appliances - "osa"
env_name              = "dev"     # <= 4 characters, e.g. dev, test, prod
tags                  = {}        # Optional tags for all resources: e.g. { CostCenter = "1111" }

# Custom Azure Cloud configurations where client has existing resources:
# Resource Group and/or Virtual Network and/or Storage Account.
# Please uncomment and provide values to the custom resources if needed.
#
# custom_resource_group_name = "custom-rg"
# custom_virtual_network = {
#   name        = "custom-vnet"
#   resource_group_name     = "custom-rg"
#   subnet_name = "custom-subnet"
# }
# custom_storage_account = {
#   name    = "custom-st"
#   resource_group_name = "custom-rg"
# }

# Please comment out the "storage_account" block if using a custom storage account.
# Diagnostic storage account configuration.
storage_account = {
  account_kind             = "Storage" # Options: Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage
  account_tier             = "Standard"
  account_replication_type = "LRS" # Options: LRS, GRS
}

# Please comment out the "virtual_network" block if using a custom virtual network.
# Virtual Network configuration. VM Network interfaces consume IP addresses from the defined subnets.
virtual_network = {
  address_space = ["10.0.0.0/16"] # CIDR notation
  subnets = [
    {
      name             = "onesign"       # Subnet name
      address_prefixes = ["10.0.1.0/24"] # Subnet CIDR notation
    }
  ]
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
vm_nic_subnet_name = "onesign" # Reference to the subnet name defined in the "virtual_network" block. # Please comment out it in case of using a custom virtual network.
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
