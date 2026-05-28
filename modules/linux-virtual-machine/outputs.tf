output "id" {
  description = "Virtual machine ID."
  value       = azurerm_linux_virtual_machine.this.id
}

output "name" {
  description = "Virtual machine name."
  value       = azurerm_linux_virtual_machine.this.name
}

output "network_interface_id" {
  description = "Primary network interface ID."
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "Primary private IP address."
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip_address" {
  description = "Public IP address, if enabled."
  value       = try(azurerm_public_ip.this[0].ip_address, null)
}
