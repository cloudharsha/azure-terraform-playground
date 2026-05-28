output "resource_group_name" {
  description = "Resource group created for the virtual machine."
  value       = module.resource_group.name
}

output "virtual_network_name" {
  description = "Name of the virtual network."
  value       = module.virtual_network.name
}

output "subnet_ids" {
  description = "Subnet IDs keyed by subnet name."
  value       = module.virtual_network.subnet_ids
}

output "virtual_machine_name" {
  description = "Name of the virtual machine."
  value       = module.linux_virtual_machine.name
}

output "virtual_machine_id" {
  description = "ID of the virtual machine."
  value       = module.linux_virtual_machine.id
}

output "private_ip_address" {
  description = "Private IP address assigned to the virtual machine."
  value       = module.linux_virtual_machine.private_ip_address
}

output "public_ip_address" {
  description = "Public IP address assigned to the virtual machine, if enabled."
  value       = module.linux_virtual_machine.public_ip_address
}
