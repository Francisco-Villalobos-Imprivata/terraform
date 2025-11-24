locals {
  location             = replace(lower(var.location), " ", "_")
  resource_type_list   = split("/", var.resource_type)
  resource_type_first  = local.resource_type_list[0]
  resource_type_second = local.resource_type_list[1]

  delimiter = var.resource_type == "MicrosoftStorage/storageAccounts" ? "" : "-"

  # https://learn.microsoft.com/en-us/community/content/azure-resources-naming-convention-and-tagging
  # https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules
  # "Resource type"-"Project(client) name"-"Workload name"-"Environment name"-"Azure Region"-"Instance"
  # Examples:
  # rg-imp-app-dev-use-01, vm-imp-db-dev-use-01
  resource_name = format("%s%s%s%s%s%02d",
    "${local.resource_abbreviation_map[local.resource_type_first][local.resource_type_second]}${local.delimiter}",
    "${lower(var.project_name)}${local.delimiter}",
    "${lower(var.workload_name)}${local.delimiter}",
    "${lower(var.env_name)}${local.delimiter}",
    "${local.location_map[local.location]}${local.delimiter}",
    var.instance
  )
}
