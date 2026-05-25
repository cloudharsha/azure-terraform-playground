variable "prefix" {
  description = "Short lower-case prefix used to build resource names."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,20}$", var.prefix))
    error_message = "prefix must be 2-21 chars, start with a letter, and use only lower-case letters, numbers, or hyphens."
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

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Key Vault."
  type        = bool
  default     = true
}

variable "enable_rbac_authorization" {
  description = "Whether Key Vault uses Azure RBAC for data plane authorization."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags applied to the resources."
  type        = map(string)
  default     = {}
}
