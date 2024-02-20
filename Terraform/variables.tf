variable "resourc_group_name" {
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