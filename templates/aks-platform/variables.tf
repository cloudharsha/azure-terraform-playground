variable "prefix" {
  description = "Short lower-case prefix used to build resource names."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,14}$", var.prefix))
    error_message = "prefix must be 2-15 chars, start with a letter, and use only lower-case letters, numbers, or hyphens."
  }
}

variable "environment" {
  description = "Environment tag used for the deployment."
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region for the deployment."
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "aks_subnet_prefixes" {
  description = "Subnet prefixes used by the AKS node pool."
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "log_analytics_retention_in_days" {
  description = "Retention period for Log Analytics."
  type        = number
  default     = 30
}

variable "acr_sku" {
  description = "SKU for Azure Container Registry."
  type        = string
  default     = "Standard"
}

variable "acr_public_network_access_enabled" {
  description = "Whether public network access is enabled for ACR."
  type        = bool
  default     = true
}

variable "key_vault_public_network_access_enabled" {
  description = "Whether public network access is enabled for Key Vault."
  type        = bool
  default     = true
}

variable "storage_public_network_access_enabled" {
  description = "Whether public network access is enabled for Storage Account."
  type        = bool
  default     = true
}

variable "storage_container_names" {
  description = "Blob containers to create in the storage account."
  type        = list(string)
  default     = ["artifacts"]
}

variable "aks_kubernetes_version" {
  description = "Optional AKS version. Leave null to let Azure choose the recommended version."
  type        = string
  default     = null
}

variable "aks_sku_tier" {
  description = "SKU tier for AKS."
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

variable "azure_rbac_enabled" {
  description = "Whether Azure RBAC is enabled for AKS."
  type        = bool
  default     = true
}

variable "aks_admin_group_object_ids" {
  description = "Optional Microsoft Entra group object IDs granted AKS admin access."
  type        = list(string)
  default     = []
}

variable "enable_cluster_auto_scaling" {
  description = "Whether cluster autoscaling is enabled for the default node pool."
  type        = bool
  default     = true
}

variable "default_node_pool_vm_size" {
  description = "VM size used for the AKS default node pool."
  type        = string
  default     = "Standard_D4s_v5"
}

variable "default_node_pool_node_count" {
  description = "Initial node count when autoscaling is disabled, or seed count when enabled."
  type        = number
  default     = 2
}

variable "default_node_pool_min_count" {
  description = "Minimum node count for the AKS default node pool."
  type        = number
  default     = 2
}

variable "default_node_pool_max_count" {
  description = "Maximum node count for the AKS default node pool."
  type        = number
  default     = 5
}

variable "default_node_pool_max_pods" {
  description = "Maximum pods allowed per node."
  type        = number
  default     = 30
}

variable "default_node_pool_os_disk_size_gb" {
  description = "OS disk size for the AKS default node pool."
  type        = number
  default     = 128
}

variable "default_node_pool_zones" {
  description = "Availability zones for the AKS default node pool."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags applied to all resources."
  type        = map(string)
  default     = {}
}
