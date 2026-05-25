locals {
  resource_group_name = "${var.prefix}-rg"
  log_analytics_name  = "${var.prefix}-law"
  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "log-analytics"
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

module "log_analytics" {
  source = "../../modules/log-analytics"

  name                = local.log_analytics_name
  location            = var.location
  resource_group_name = module.resource_group.name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = local.common_tags
}
