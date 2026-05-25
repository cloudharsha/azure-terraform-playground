output "resource_group_name" {
  description = "Resource group created for the Key Vault."
  value       = module.resource_group.name
}

output "key_vault_name" {
  description = "Name of the Key Vault."
  value       = module.key_vault.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault."
  value       = module.key_vault.vault_uri
}
