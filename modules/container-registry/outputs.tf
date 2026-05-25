output "id" {
  description = "Azure Container Registry ID."
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Azure Container Registry name."
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Login server of the registry."
  value       = azurerm_container_registry.this.login_server
}
