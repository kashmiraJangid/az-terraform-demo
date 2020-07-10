

resource "azurerm_postgresql_server" "default" {
  name                = "${var.aksBaseName}-postgres"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  administrator_login          = "spdemoadmin"
  administrator_login_password = "Teaboy20!"

  sku_name   = "GP_Gen5_2"
  version    = "9.6"
  storage_mb = 5120

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true


  public_network_access_enabled    = true
  ssl_enforcement_enabled          = false


  tags = {
    environment = "Demo"
  }
}

resource "azurerm_postgresql_firewall_rule" "example" {
  name                = "FirewallRule1"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.default.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}

resource "azurerm_postgresql_database" "default" {
  name                = "spdemo-db"
  resource_group_name = azurerm_resource_group.default.name
  server_name         = azurerm_postgresql_server.default.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}

output "azurerm_postgresql_server" {
  value = azurerm_postgresql_server.default.name
}
output "azurerm_postgresql_database" {
  value = azurerm_postgresql_database.default.name
}