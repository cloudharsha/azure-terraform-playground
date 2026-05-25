output "resource_group_name" {
  description = "Resource group created for the registry."
  value       = module.resource_group.name
}

output "container_registry_name" {
  description = "Name of the Azure Container Registry."
  value       = module.container_registry.name
}

output "login_server" {
  description = "Registry login server."
  value       = module.container_registry.login_server
}
