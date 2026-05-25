output "resource_group_name" {
  description = "Resource group created for Log Analytics."
  value       = module.resource_group.name
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  value       = module.log_analytics.name
}

output "workspace_id" {
  description = "Workspace ID for the Log Analytics workspace."
  value       = module.log_analytics.workspace_id
}
