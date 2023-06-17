# Defines mssqldb variables
variable "rg_name" {
  type = string
}
variable "location_name" {
  type = string
}
variable "mssql_db_name" {
  type = string
}
variable "mssql_password" {
  type = string
}

resource "azurerm_mssql_server" "mssqldbtest" {
  name                         = var.mssql_db_name
  resource_group_name          = var.rg_name
  location                     = var.location_name
  version                      = "12.0"
  administrator_login          = "adminlogin"
  administrator_login_password = var.mssql_password
}

resource "azurerm_mssql_firewall_rule" "example" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.mssqldbtest.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mssql_database" "mssqldbtest" {
  name      = azurerm_mssql_server.mssqldbtest.name
  server_id = azurerm_mssql_server.mssqldbtest.id
  sku_name  = "Basic"
}
