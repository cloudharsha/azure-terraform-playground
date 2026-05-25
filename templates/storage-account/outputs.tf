output "resource_group_name" {
  description = "Resource group created for the storage account."
  value       = module.resource_group.name
}

output "storage_account_name" {
  description = "Name of the storage account."
  value       = module.storage_account.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint."
  value       = module.storage_account.primary_blob_endpoint
}
