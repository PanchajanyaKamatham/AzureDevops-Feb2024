variable "resource_group_name" {
  type        = string
}

variable "location" {
  type    = string
}

variable "storage_account_name" {
  type    = string
}

variable "tags" {
}

variable "virtual_network_name" {
  type    = string
}

variable "virtual_network_address" {
  type    = list(any)
}

variable "subnet_name" {
  type    = string
}

variable "subnet_address" {
  type    = list(any)
}

variable "publicip_name" {
  type    = string
}

variable "nsg_name" {
  type    = string
}

variable "nic_name" {
  type    = string
}

variable "vm_name" {
  type    = string
}

variable "vm_size" {
  type    = string
}

variable "admin_username" {
  type    = string
}

variable "admin_password" {
  type    = string
}