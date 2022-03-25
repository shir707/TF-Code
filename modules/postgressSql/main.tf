resource "azurerm_private_dns_zone" "example" {
  name                = "example.postgres.database.azure.com"
  resource_group_name      = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "exampleVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = var.network_id
  resource_group_name      = var.resource_group_name
   depends_on = [
     azurerm_private_dns_zone.example
  ]
}

resource "azurerm_postgresql_flexible_server" "dbServer" {
  name                   = "db-psqlflexibleserver"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  version                = "12"
  delegated_subnet_id    = var.privateSubnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.example.id
  administrator_login    = "postgres"
  administrator_password = "p@ssw0rd42"
  zone                   = "1"

  storage_mb = 32768

  sku_name   =  "B_Standard_B1ms"
  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]

}