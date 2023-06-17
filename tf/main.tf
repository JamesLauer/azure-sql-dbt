# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.51.0"
    }
  }
  required_version = ">=1.4.2"
  backend "azurerm" {
    resource_group_name  = var.rg_name
    storage_account_name = var.storage_name
    container_name       = var.container_name
    key                  = "prod.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

# Project environment variables - set from .github/actions.yaml
variable "rg_name" {
  type = string
}
variable "storage_name" {
  type = string
}
variable "storage_id" {
  type = string
}
variable "location_name" {
  type = string
}
variable "container_name" {
  type = string
}
variable "rg_id" {
  type = string
}
variable "mssql_password" {
  type = string
}
variable "blob_connection_string" {
  type = string
}
variable "sqldb_connection_string" {
  type = string
}
variable "dataset_name" {
  default = [
    "raw_person_address",
    "raw_person_businessentity",
    "raw_person_businessentityaddress",
    "raw_person_person",
    "raw_production_product",
    "raw_purchasing_purchaseorderdetail",
    "raw_sales_salesorderdetail",
    "raw_sales_salesorderheader",
    "raw_sales_salesperson"
  ]
  type = set(string)
}


# Defines project input variables
locals {
  global_input_vars = {
    rg_id          = var.rg_id
    rg_name        = var.rg_name
    location_name  = var.location_name
    storage_name   = var.storage_name
    container_name = var.container_name
  }
  mssqldb_input_vars = {
    mssql_db_name  = "mssqldb"
    mssql_password = var.mssql_password
  }
  datafactory_input_vars = {
    datafactory_name        = "csv-load-df"
    storage_id              = var.storage_id
    blob_connection_string  = var.blob_connection_string
    sqldb_connection_string = var.sqldb_connection_string
  }
}

# Import sql db module
module "mssqldb" {
  source         = "./mssqldb"
  location_name  = local.global_input_vars["location_name"]
  rg_name        = local.global_input_vars["rg_name"]
  mssql_db_name  = "${local.mssqldb_input_vars["mssql_db_name"]}-${local.global_input_vars["rg_name"]}"
  mssql_password = ""
}

# Import data factory module
module "datafactory" {
  source                  = "./datafactory/datafactory"
  location_name           = local.global_input_vars["location_name"]
  rg_name                 = local.global_input_vars["rg_name"]
  datafactory_name        = local.datafactory_input_vars["datafactory_name"]
  blob_connection_string  = local.datafactory_input_vars["blob_connection_string"]
  sqldb_connection_string = local.datafactory_input_vars["sqldb_connection_string"]
}

# Import data factory pipeline module
module "pipeline" {
  source                  = "./datafactory/pipeline"
  datafactory_name        = "${local.datafactory_input_vars["datafactory_name"]}-${local.global_input_vars["rg_name"]}"
  container_name          = local.global_input_vars["container_name"]
  datafactory_id          = module.datafactory.datafactory_id
  blob_store_service_name = module.datafactory.blob_store_service_name
  sql_db_service_name     = module.datafactory.sql_db_service_name
  storage_id              = local.datafactory_input_vars["storage_id"]
  for_each                = toset(var.dataset_name)
  dataset_name            = each.key
}

