variable "name" {
  description = "Name of the virtual machine."
  type        = string
}

variable "location" {
  description = "Azure region for the virtual machine."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that contains the virtual machine resources."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID used by the virtual machine network interface."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B2s"
}

variable "computer_name" {
  description = "Optional guest hostname. Defaults to the VM name."
  type        = string
  default     = null
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

  validation {
    condition = contains(
      ["Standard_LRS", "StandardSSD_LRS", "Premium_LRS", "StandardSSD_ZRS", "Premium_ZRS"],
      var.os_disk_storage_account_type
    )
    error_message = "os_disk_storage_account_type must be a supported Azure managed disk SKU."
  }
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB."
  type        = number
  default     = 30
}

variable "source_image_reference" {
  description = "Marketplace image reference used by the VM."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "custom_data" {
  description = "Base64-encoded custom data, such as cloud-init."
  type        = string
  default     = null
  sensitive   = true
}

variable "tags" {
  description = "Tags applied to the virtual machine resources."
  type        = map(string)
  default     = {}
}
