variable "name" {
  description = "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "account_kind" {
  description = " (Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2"
  type        = string
  default     = "Storage"
}

variable "account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
  type        = string
  default     = "LRS"
}

variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  type        = string
  default     = null
  validation {
    condition     = var.access_tier != null ? contains(["Hot", "Cool", "Cold", "Premium"], var.access_tier) : true
    error_message = "Account access tier is not valid. Please use one of the following: Hot or Cool."
  }
  validation {
    condition     = var.access_tier != null ? contains(["BlobStorage", "FileStorage", "StorageV2"], var.account_kind) : true
    error_message = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  }
}

variable "https_traffic_only_enabled" {
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  type        = string
  default     = "TLS1_2"
  validation {
    condition     = contains(["TLS1_0", "TLS1_1", "TLS1_2"], coalesce(var.min_tls_version, "TLS1_2"))
    error_message = "Min TLS version is not valid. Possible values are TLS1_0, TLS1_1, and TLS1_2."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public. Defaults to true."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "(Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). Defaults to true."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether the public network access is enabled? Defaults to true."
  type        = bool
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags which should be assigned to the Resource Group."
  type        = map(any)
  default     = {}
}
