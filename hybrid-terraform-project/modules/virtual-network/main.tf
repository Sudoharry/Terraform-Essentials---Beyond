resource "azurerm_virtual_network" "vnet" {
  name                = var.azure_vnet_name
  address_space       = var.azure_address_space
  location            = var.azure_location
  resource_group_name = var.azure_resource_group_name
}