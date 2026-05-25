variable "name" {
  description = "Name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "Azure region for the AKS cluster."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "Optional Kubernetes version for the cluster."
  type        = string
  default     = null
}

variable "sku_tier" {
  description = "SKU tier for the AKS cluster."
  type        = string
  default     = "Free"
}

variable "automatic_upgrade_channel" {
  description = "Automatic upgrade channel for AKS."
  type        = string
  default     = null
}

variable "private_cluster_enabled" {
  description = "Whether the AKS API server is private."
  type        = bool
  default     = false
}

variable "oidc_issuer_enabled" {
  description = "Whether the AKS OIDC issuer is enabled."
  type        = bool
  default     = true
}

variable "workload_identity_enabled" {
  description = "Whether workload identity is enabled."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "Optional Log Analytics workspace ID for the OMS agent."
  type        = string
  default     = null
}

variable "tenant_id" {
  description = "Optional tenant ID used when Azure RBAC is enabled."
  type        = string
  default     = null
}

variable "admin_group_object_ids" {
  description = "Optional Azure AD group object IDs with cluster admin permissions."
  type        = list(string)
  default     = []
}

variable "azure_rbac_enabled" {
  description = "Whether Azure RBAC is enabled for the cluster."
  type        = bool
  default     = true
}

variable "default_node_pool" {
  description = "Configuration for the AKS default node pool."
  type = object({
    name                = string
    vm_size             = string
    enable_auto_scaling = bool
    node_count          = number
    min_count           = number
    max_count           = number
    max_pods            = number
    os_disk_size_gb     = number
    vnet_subnet_id      = string
    zones               = list(string)
  })
}

variable "network_plugin" {
  description = "Network plugin used by AKS."
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy used by AKS."
  type        = string
  default     = "azure"
}

variable "load_balancer_sku" {
  description = "Load balancer SKU for AKS."
  type        = string
  default     = "standard"
}

variable "outbound_type" {
  description = "Outbound type for AKS."
  type        = string
  default     = "loadBalancer"
}

variable "service_cidr" {
  description = "CIDR range used for Kubernetes services."
  type        = string
  default     = "10.2.0.0/24"
}

variable "dns_service_ip" {
  description = "IP address used by kube-dns within the service CIDR."
  type        = string
  default     = "10.2.0.10"
}

variable "tags" {
  description = "Tags applied to the AKS cluster."
  type        = map(string)
  default     = {}
}
