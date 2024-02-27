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

# Azure terraform backend
terraform {
  backend "azurerm" {
    resource_group_name  = "storage-account-resource-group"
    storage_account_name = "saanvikit20240118"
    container_name       = "tfstate"
    key                  = "remotemodule.terraform.tfstate"
  }
}

module "remote_module" {
  source = "git::https://github.com/azureramakrishna/AzureDevops-Feb2024.git"

  resource_group_name  = "remote-module-rg"
  location             = "uksouth"
  storage_account_name = "remotesa00000"
  tags = {
    environment = "dev"
  }
  count_value = 9
}