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

variable "sku" {
  description = "Pricing tier for the Log Analytics workspace."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Retention period for logs in days."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Additional tags applied to the resources."
  type        = map(string)
  default     = {}
}
