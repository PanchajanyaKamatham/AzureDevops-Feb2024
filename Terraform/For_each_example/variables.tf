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
  type    = set(string)
  default = ["ramakrishna20240226", "ravi20240226", "rajesh20240226", "prathyusa20240226", "sireesha20240226"]
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