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

  client_id       = var.clientid
  client_secret   = var.secret
  tenant_id       = var.tenantid
  subscription_id = var.subscriptionid
}

# Azure terraform backend
terraform {
  backend "azurerm" {
    resource_group_name  = "storage-account-resource-group"
    storage_account_name = "saanvikit20240118"
    container_name       = "tfstate"
    key                  = "multistorage.terraform.tfstate"
  }
}

# Create a azure resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = "${var.storage_account_name}${count.index}"
  count                    = var.count_value
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}
