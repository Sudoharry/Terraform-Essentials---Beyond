output "storage_account_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}

output "container_name" {
  description = "Blob container name"
  value       = azurerm_storage_container.container.name
}
