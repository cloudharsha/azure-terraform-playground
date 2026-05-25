variable "name" {
  description = "Name of the Log Analytics workspace."
  type        = string
}

variable "location" {
  description = "Azure region for the Log Analytics workspace."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the Log Analytics workspace."
  type        = string
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
  description = "Tags applied to the Log Analytics workspace."
  type        = map(string)
  default     = {}
}
