resource "azurerm_resource_group" "resource_group" {
  name     = "${var.base_name}RG"
  location = var.location
}