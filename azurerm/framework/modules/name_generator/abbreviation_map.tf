locals {

  # Azure cloud location short names
  location_map = {
    east_us          = "use"
    east_us_2        = "use2"
    central_us       = "usc"
    north_central_us = "usnc"
    south_central_us = "ussc"
    west_central_us  = "uswc"
    west_us          = "usw"
    west_us_2        = "usw2"
    west_us_3        = "usw3"
  }

  # https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations
  resource_abbreviation_map = {
    MicrosoftCompute = {
      virtualMachines         = "vm"
      availabilitySets        = "avail"
      virtualMachineScaleSets = "vmss"
    }
    ManagedIdentity = {
      userAssignedIdentities = "id"
    }
    MicrosoftKeyVault = {
      vaults  = "kv"
      secrets = "sec"
    }
    MicrosoftNetwork = {
      virtualNetworks         = "vnet"
      virtualNetworks_subnets = "snet"
      networkSecurityGroups   = "nsg"
    }
    MicrosoftResources = {
      resourceGroups = "rg"
    }
    MicrosoftStorage = {
      storageAccounts = "st"
    }
  }

}
