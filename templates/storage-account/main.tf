locals {
  sanitized_prefix     = replace(var.prefix, "-", "")
  resource_group_name  = "${var.prefix}-rg"
  storage_account_name = substr("${local.sanitized_prefix}st", 0, 24)
  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "storage-account"
    },
    var.tags
  )
}

module "resource_group" {
  source = "../../modules/resource-group"

  name     = local.resource_group_name
  location = var.location
  tags     = local.common_tags
}

module "storage_account" {
  source = "../../modules/storage-account"

  name                          = local.storage_account_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  account_tier                  = var.account_tier
  account_replication_type      = var.account_replication_type
  public_network_access_enabled = var.public_network_access_enabled
  is_hns_enabled                = var.is_hns_enabled
  container_names               = var.container_names
  tags                          = local.common_tags
}
