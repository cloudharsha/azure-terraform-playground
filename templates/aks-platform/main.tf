data "azurerm_client_config" "current" {}

locals {
  sanitized_prefix        = replace(var.prefix, "-", "")
  resource_group_name     = "${var.prefix}-rg"
  virtual_network_name    = "${var.prefix}-vnet"
  log_analytics_name      = "${var.prefix}-law"
  aks_name                = "${var.prefix}-aks"
  container_registry_name = substr("${local.sanitized_prefix}acr", 0, 50)
  key_vault_name          = substr("${var.prefix}-kv", 0, 24)
  storage_account_name    = substr("${local.sanitized_prefix}st", 0, 24)

  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "aks-platform"
    },
    var.tags
  )

  subnets = {
    aks = {
      address_prefixes  = var.aks_subnet_prefixes
      service_endpoints = ["Microsoft.KeyVault", "Microsoft.Storage"]
    }
  }
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
  address_space       = var.vnet_address_space
  subnets             = local.subnets
  tags                = local.common_tags
}

module "log_analytics" {
  source = "../../modules/log-analytics"

  name                = local.log_analytics_name
  location            = var.location
  resource_group_name = module.resource_group.name
  retention_in_days   = var.log_analytics_retention_in_days
  tags                = local.common_tags
}

module "container_registry" {
  source = "../../modules/container-registry"

  name                          = local.container_registry_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  sku                           = var.acr_sku
  public_network_access_enabled = var.acr_public_network_access_enabled
  tags                          = local.common_tags
}

module "key_vault" {
  source = "../../modules/key-vault"

  name                          = local.key_vault_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = var.key_vault_public_network_access_enabled
  tags                          = local.common_tags
}

module "storage_account" {
  source = "../../modules/storage-account"

  name                          = local.storage_account_name
  location                      = var.location
  resource_group_name           = module.resource_group.name
  container_names               = var.storage_container_names
  public_network_access_enabled = var.storage_public_network_access_enabled
  tags                          = local.common_tags
}

module "aks" {
  source = "../../modules/aks"

  name                       = local.aks_name
  location                   = var.location
  resource_group_name        = module.resource_group.name
  dns_prefix                 = local.aks_name
  kubernetes_version         = var.aks_kubernetes_version
  sku_tier                   = var.aks_sku_tier
  automatic_upgrade_channel  = var.automatic_upgrade_channel
  private_cluster_enabled    = var.private_cluster_enabled
  log_analytics_workspace_id = module.log_analytics.id
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  admin_group_object_ids     = var.aks_admin_group_object_ids
  azure_rbac_enabled         = var.azure_rbac_enabled
  default_node_pool = {
    name                = "system"
    vm_size             = var.default_node_pool_vm_size
    enable_auto_scaling = var.enable_cluster_auto_scaling
    node_count          = var.default_node_pool_node_count
    min_count           = var.default_node_pool_min_count
    max_count           = var.default_node_pool_max_count
    max_pods            = var.default_node_pool_max_pods
    os_disk_size_gb     = var.default_node_pool_os_disk_size_gb
    vnet_subnet_id      = module.virtual_network.subnet_ids["aks"]
    zones               = var.default_node_pool_zones
  }
  tags = local.common_tags
}

resource "azurerm_role_assignment" "aks_to_acr" {
  scope                            = module.container_registry.id
  role_definition_name             = "AcrPull"
  principal_id                     = module.aks.kubelet_identity_object_id
  principal_type                   = "ServicePrincipal"
  skip_service_principal_aad_check = true

  depends_on = [module.aks, module.container_registry]
}
