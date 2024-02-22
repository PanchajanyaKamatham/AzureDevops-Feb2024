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
    key                  = "terraform.tfstate"
  }
}

# Create a azure resource group
# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group_name
#   location = var.location
# }



# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = lower(var.storage_account_name)
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

# # Create Virtual Network
# resource "azurerm_virtual_network" "vnet" {
#   depends_on = [ azurerm_network_security_group.nsg ]
#   name                = var.virtual_network_name
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   address_space       = var.virtual_network_address
#   tags                = var.tags
# }

# # Create subnet
# resource "azurerm_subnet" "subnet" {
#   depends_on = [ azurerm_virtual_network.vnet, azurerm_network_security_group.nsg]
#   name                 = var.subnet_name
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = var.subnet_address
# }

# Create a publicip
resource "azurerm_public_ip" "publicip" {
  name                = var.publicip_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  allocation_method   = "Static"


  tags = var.tags
}

# Create a Network security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Associate nsg with subnet
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = data.azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create a NIC
resource "azurerm_network_interface" "nic" {
  depends_on          = [azurerm_public_ip.publicip, data.azurerm_virtual_network.vnet, data.azurerm_subnet.snet]
  name                = var.nic_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }
}

# Create a windows virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  depends_on          = [azurerm_network_interface.nic]
  name                = var.vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = data.azurerm_key_vault_secret.keyvaultsecret.value
  #zone                = 3
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}