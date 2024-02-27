variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "storageaccountname" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address" {
  type = list(any)
}

variable "subnet" {
  type = string
}

variable "subnetaddress" {
  type = list(any)
}

variable "pip_name" {
  type = string
}

variable "nsg" {
  type = string
}

variable "nic" {
  type = string
}

variable "vm" {
  type = string
}

variable "adminuser" {
  type = string
}

variable "password" {
}

variable "vmsize" {

}

variable "tags" {
  default = {
    environment = "prod"
  }
}