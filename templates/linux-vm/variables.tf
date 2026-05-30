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

variable "vnet_address_space" {
  description = "Address spaces assigned to the virtual network."
  type        = list(string)
  default     = ["10.30.0.0/16"]
}

variable "vm_subnet_prefixes" {
  description = "Address prefixes assigned to the VM subnet."
  type        = list(string)
  default     = ["10.30.1.0/24"]
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Administrator username for the virtual machine."
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH public key used for the administrator account."
  type        = string
  sensitive   = true
}

variable "public_ip_enabled" {
  description = "Whether to create and attach a public IP address."
  type        = bool
  default     = true
}

variable "ssh_allowed_cidrs" {
  description = "CIDR ranges allowed to connect over SSH."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "os_disk_storage_account_type" {
  description = "Managed disk storage account type for the OS disk."
  type        = string
  default     = "Standard_LRS"
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB."
  type        = number
  default     = 30
}

variable "custom_data" {
  description = "Base64-encoded custom data, such as cloud-init."
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "Additional tags applied to the resources."
  type        = map(string)
  default     = {}
}
