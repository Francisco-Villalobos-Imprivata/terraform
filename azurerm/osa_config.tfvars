# Full creation deployment of OneSign Appliances in Azure.
# It will create all resources: Resource Group, Virtual Network, Storage Account, and VMs.

azure_subscription_id = "c3217123-3040-49c1-bacd-460ac7518c91"
location              = "West US" # Azure region. Please use one of: East US, Central US, North Central US.
project_name          = "imp"     # <= 7 characters. e.g. Imprivata - "imp"
workload_name         = "osa"     # <= 3 characters. e.g. OneSign Appliances - "osa"
env_name              = "dev"     # <= 4 characters, e.g. dev, test, prod
tags                  = {}        # Optional tags for all resources: e.g. { CostCenter = "1111" }

# Diagnostic storage account configuration.
storage_account = {
  account_kind             = "Storage" # Options: Storage, StorageV2, BlobStorage, FileStorage, BlockBlobStorage
  account_tier             = "Standard"
  account_replication_type = "LRS" # Options: LRS, GRS
}

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
vm_nic_subnet_name = "onesign" # Reference to the subnet name defined in the "virtual_network" block.
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
