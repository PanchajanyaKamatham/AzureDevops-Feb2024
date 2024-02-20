terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.70.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a azure resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resourc_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = lower(var.storage_account_name)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

output "storage_account_endpoint" {
  value = azurerm_storage_account.storage.primary_blob_endpoint
}