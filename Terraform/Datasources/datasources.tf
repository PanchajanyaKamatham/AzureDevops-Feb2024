#Use this data source to access information about an existing Resource Group.
data "azurerm_resource_group" "rg" {
  name = "test-group"
}

#Use this data source to access information about an existing Virtual Network.
data "azurerm_virtual_network" "vnet" {
  name                = "test-vnet"
  resource_group_name = "test-group"
}

#Use this data source to access information about an existing Subnet within a Virtual Network
data "azurerm_subnet" "snet" {
  name                 = "default"
  virtual_network_name = "test-vnet"
  resource_group_name  = "test-group"
}

#Use this data source to access information about an existing Key Vault.
data "azurerm_key_vault" "keyvault" {
  name                = "testgroupkv124"
  resource_group_name = "test-group"
}

#Use this data source to access information about an existing Key Vault Secret.
data "azurerm_key_vault_secret" "keyvaultsecret" {
  name         = "VMPassword"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}