locals {
  resource_group_name  = "${var.prefix}-rg"
  virtual_network_name = "${var.prefix}-vnet"
  virtual_machine_name = "${var.prefix}-vm"

  common_tags = merge(
    {
      environment = var.environment
      managed-by  = "terraform"
      template    = "linux-vm"
    },
    var.tags
  )

  subnets = {
    vm = {
      address_prefixes  = var.vm_subnet_prefixes
      service_endpoints = []
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

module "linux_virtual_machine" {
  source = "../../modules/linux-virtual-machine"

  name                         = local.virtual_machine_name
  location                     = var.location
  resource_group_name          = module.resource_group.name
  subnet_id                    = module.virtual_network.subnet_ids["vm"]
  vm_size                      = var.vm_size
  admin_username               = var.admin_username
  admin_ssh_public_key         = var.admin_ssh_public_key
  public_ip_enabled            = var.public_ip_enabled
  ssh_allowed_cidrs            = var.ssh_allowed_cidrs
  os_disk_storage_account_type = var.os_disk_storage_account_type
  os_disk_size_gb              = var.os_disk_size_gb
  custom_data                  = var.custom_data
  tags                         = local.common_tags
}
