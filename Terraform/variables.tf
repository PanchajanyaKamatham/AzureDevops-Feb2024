variable "resource_group_name" {
  type        = string
  description = "Name of the resourcegroup"
  default     = "azurerm-terraform-group"
}

variable "location" {
  type    = string
  default = "uksouth"
}

variable "storage_account_name" {
  type    = string
  default = "Terraformsa20240220"
}

variable "tags" {
  default = {
    environment = "prod"
    department  = "IT-Cloud"
  }
}

variable "virtual_network_name" {
  type    = string
  default = "arm-terraform-vnet"
}

variable "virtual_network_address" {
  type    = list(any)
  default = ["192.168.0.0/24"]
}

variable "subnet_name" {
  type    = string
  default = "arm-snet"
}

variable "subnet_address" {
  type    = list(any)
  default = ["192.168.0.0/25"]
}

variable "publicip_name" {
  type    = string
  default = "arm-pip"
}

variable "nsg_name" {
  type    = string
  default = "arm-nsg"
}

variable "nic_name" {
  type    = string
  default = "arm-nic"
}

variable "vm_name" {
  type    = string
  default = "arm-vm"
}

variable "vm_size" {
  type    = string
  default = "Standard_Ds1_v2"
}

variable "admin_username" {
  type    = string
  default = "azureuser"
}

variable "admin_password" {
  type    = string
}