locals {
  sanitized_prefix        = replace(var.prefix, "-", "")
  resource_group_name     = "${var.prefix}-rg"
  container_registry_name = substr("${local.sanitized_prefix}acr", 0, 50)
  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "container-registry"
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

module "container_registry" {
  source = "../../modules/container-registry"

  name                          = local.container_registry_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.common_tags
}
