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
    key                  = "prodvm.terraform.tfstate"
  }
}

module "prod_vm" {
  source = "../VMModule/"

  resource_group_name     = var.rg_name
  location                = var.location
  storage_account_name    = var.storageaccountname
  virtual_network_name    = var.vnet_name
  virtual_network_address = var.vnet_address
  subnet_name             = var.subnet
  subnet_address          = var.subnetaddress
  publicip_name           = var.pip_name
  nsg_name                = var.nsg
  tags                    = var.tags
  nic_name                = var.nic
  vm_name                 = var.vm
  vm_size                 = var.vmsize
  admin_username          = var.adminuser
  admin_password          = var.password

}