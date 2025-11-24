provider "azurerm" {
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id

  resource_provider_registrations = "none" # can be: core, extended, all, or none.

  features {
    virtual_machine {
      detach_implicit_data_disk_on_deletion = false
      delete_os_disk_on_deletion            = true
      skip_shutdown_and_force_delete        = false
    }
  }
}

terraform {
  #-> Configure remote backend (e.g. - Azure Storage Account)
  # backend "azurerm" {}

  #-> Configure local backend (local running only)
  backend "local" {
    path = "./local.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.41.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }
  required_version = ">= 1.12.0"
}
