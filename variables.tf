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
  default = "Saanvikit2222"
}

variable "tags" {
  default = {
    environment = "prod"
    department  = "IT-Cloud"
  }
}

variable "count_value" {
  type    = number
  default = 20
}