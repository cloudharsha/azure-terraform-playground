output "resource_group_name" {
  description = "Resource group created for the AKS platform."
  value       = module.resource_group.name
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster."
  value       = module.aks.name
}

output "aks_cluster_fqdn" {
  description = "FQDN of the AKS API server."
  value       = module.aks.fqdn
}

output "aks_subnet_id" {
  description = "Subnet ID used by AKS."
  value       = module.virtual_network.subnet_ids["aks"]
}

output "acr_login_server" {
  description = "Login server for the Azure Container Registry."
  value       = module.container_registry.login_server
}

output "key_vault_uri" {
  description = "URI of the Key Vault."
  value       = module.key_vault.vault_uri
}

output "storage_account_name" {
  description = "Name of the storage account."
  value       = module.storage_account.name
}
