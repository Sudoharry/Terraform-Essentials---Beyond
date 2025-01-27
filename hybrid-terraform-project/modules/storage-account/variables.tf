variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
}

variable "location" {
  description = "Azure region"
  default = "westindia"
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
}

variable "container_name" {
  description = "Name of the blob storage container"
}
