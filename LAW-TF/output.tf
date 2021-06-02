# #############################################################################
# # OUTPUTS Log Analytics Workspace
# #############################################################################

output "law_workspace" {
  description = ""
  value       = azurerm_log_analytics_workspace.logs
  sensitive = true
}

output "law_id" {
  description = ""
  value       = azurerm_log_analytics_workspace.logs.id
}

output "law_name" {
  description = ""
  value       = azurerm_log_analytics_workspace.logs.name
}

output "law_key" {
  description = ""
  value       = azurerm_log_analytics_workspace.logs.primary_shared_key
  sensitive = true
}

output "law_workspace_id" {
  description = ""
  value       = azurerm_log_analytics_workspace.logs.workspace_id
}


