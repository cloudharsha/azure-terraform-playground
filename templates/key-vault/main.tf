data "azurerm_client_config" "current" {}

locals {
  resource_group_name = "${var.prefix}-rg"
  key_vault_name      = substr("${var.prefix}-kv", 0, 24)
  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "key-vault"
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

module "key_vault" {
  source = "../../modules/key-vault"

  name                          = local.key_vault_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = var.public_network_access_enabled
  enable_rbac_authorization     = var.enable_rbac_authorization
  tags                          = local.common_tags
}
