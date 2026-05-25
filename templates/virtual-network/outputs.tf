output "resource_group_name" {
  description = "Resource group created for the virtual network."
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
