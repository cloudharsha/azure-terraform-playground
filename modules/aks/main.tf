resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  sku_tier            = var.sku_tier

  automatic_upgrade_channel = var.automatic_upgrade_channel
  private_cluster_enabled   = var.private_cluster_enabled
  oidc_issuer_enabled       = var.oidc_issuer_enabled
  workload_identity_enabled = var.workload_identity_enabled

  default_node_pool {
    name                 = var.default_node_pool.name
    vm_size              = var.default_node_pool.vm_size
    auto_scaling_enabled = var.default_node_pool.enable_auto_scaling
    node_count           = var.default_node_pool.enable_auto_scaling ? null : var.default_node_pool.node_count
    min_count            = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.min_count : null
    max_count            = var.default_node_pool.enable_auto_scaling ? var.default_node_pool.max_count : null
    max_pods             = var.default_node_pool.max_pods
    os_disk_size_gb      = var.default_node_pool.os_disk_size_gb
    vnet_subnet_id       = var.default_node_pool.vnet_subnet_id
    type                 = "VirtualMachineScaleSets"
    zones                = var.default_node_pool.zones
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    network_policy    = var.network_policy
    load_balancer_sku = var.load_balancer_sku
    outbound_type     = var.outbound_type
    service_cidr      = var.service_cidr
    dns_service_ip    = var.dns_service_ip
  }

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id == null ? [] : [var.log_analytics_workspace_id]

    content {
      log_analytics_workspace_id = oms_agent.value
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_rbac_enabled || length(var.admin_group_object_ids) > 0 ? [1] : []

    content {
      tenant_id              = var.tenant_id
      admin_group_object_ids = var.admin_group_object_ids
      azure_rbac_enabled     = var.azure_rbac_enabled
    }
  }

  tags = var.tags
}
