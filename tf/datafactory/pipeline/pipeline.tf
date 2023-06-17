variable "container_name" {
  type = string
}
variable "datafactory_id" {
  type = string
}
variable "datafactory_name" {
  type = string
}
variable "blob_store_service_name" {
  type = string
}
variable "sql_db_service_name" {
  type = string
}
variable "dataset_name" {
  type = string
}
variable "storage_id" {
  type = string
}

locals {
  address_table_schema = jsondecode(file("${path.module}/json/dfconfig_${var.dataset_name}.json"))
}

resource "azurerm_data_factory_dataset_delimited_text" "datafactory" {
  name                = var.dataset_name
  data_factory_id     = var.datafactory_id
  linked_service_name = var.blob_store_service_name

  azure_blob_storage_location {
    container = var.container_name
    path      = "data/raw"
    filename  = "${var.dataset_name}.csv"
  }

  row_delimiter       = "\n"
  encoding            = "UTF-8"
  first_row_as_header = true
  null_value          = "NULL"

}

resource "azurerm_data_factory_custom_dataset" "datafactory" {
  name                 = "${var.dataset_name}_table"
  data_factory_id      = var.datafactory_id
  type                 = "AzureSqlTable"
  type_properties_json = jsonencode(local.address_table_schema.json_type_properties)
  schema_json          = jsonencode(local.address_table_schema.json_schema)

  linked_service {
    name = var.sql_db_service_name
  }
}

resource "azurerm_data_factory_pipeline" "datafactory" {
  name            = "datafactory-${var.dataset_name}"
  data_factory_id = var.datafactory_id
  activities_json = jsonencode(local.address_table_schema.activities_json)
}

resource "azurerm_data_factory_trigger_blob_event" "datafactory" {
  name                = "trigger-${var.dataset_name}"
  data_factory_id     = var.datafactory_id
  storage_account_id  = var.storage_id
  events              = ["Microsoft.Storage.BlobCreated"]
  blob_path_ends_with = "${var.dataset_name}.csv"
  ignore_empty_blobs  = true
  activated           = true

  pipeline {
    name = azurerm_data_factory_pipeline.datafactory.name
    parameters = {
      Env = "Prod"
    }
  }
}

