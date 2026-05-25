variable "name" {
  description = "Name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the Azure Container Registry."
  type        = string
}

variable "location" {
  description = "Azure region for the Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "SKU for the Azure Container Registry."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Whether admin access is enabled for the registry."
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the registry."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to the registry."
  type        = map(string)
  default     = {}
}
