/*output "aws_instance_public_ip" {
  value = module.aws_instance.aws_instance_public_ip
} */

output "azure_storage_account_id" {
  description = "Azure Storage Account ID"
  value       = module.azure_storage.azure_storage_account_id
}
