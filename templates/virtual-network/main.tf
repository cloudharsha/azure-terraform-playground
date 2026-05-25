locals {
  resource_group_name  = "${var.prefix}-rg"
  virtual_network_name = "${var.prefix}-vnet"
  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "virtual-network"
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

module "virtual_network" {
  source = "../../modules/virtual-network"

  name                = local.virtual_network_name
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = local.common_tags
}
