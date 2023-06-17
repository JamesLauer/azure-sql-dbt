# Defines df variables
variable "rg_name" {
  type = string
}
variable "location_name" {
  type = string
}
variable "datafactory_name" {
  type = string
}
variable "blob_connection_string" {
  type = string
}
variable "sqldb_connection_string" {
  type = string
}

resource "azurerm_data_factory" "datafactory" {
  name                = var.datafactory_name
  location            = var.location_name
  resource_group_name = var.rg_name
}

resource "azurerm_data_factory_linked_service_azure_blob_storage" "datafactory" {
  name              = "blob_store"
  data_factory_id   = azurerm_data_factory.datafactory.id
  connection_string = var.blob_connection_string
}

resource "azurerm_data_factory_linked_service_azure_sql_database" "datafactory" {
  name              = "sql_db"
  data_factory_id   = azurerm_data_factory.datafactory.id
  connection_string = var.sqldb_connection_string != "" ? var.sqldb_connection_string : "default"
}

output "datafactory_id" {
  value = azurerm_data_factory.datafactory.id
}
output "datafactory_name" {
  value = azurerm_data_factory.datafactory.name
}
output "blob_store_service_name" {
  value = azurerm_data_factory_linked_service_azure_blob_storage.datafactory.name
}
output "sql_db_service_name" {
  value = azurerm_data_factory_linked_service_azure_sql_database.datafactory.name
}