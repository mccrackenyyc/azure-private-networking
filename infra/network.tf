resource "azurerm_resource_group" "apn_network_rg" {
  name     = "apn-network-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_network_security_group" "apn_nsg" {
  name                = "apn-nsg-${var.env_name}"
  location            = azurerm_resource_group.apn_network_rg.location
  resource_group_name = azurerm_resource_group.apn_network_rg.name

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_virtual_network" "apn_vnet" {
  name                = "apn-vnet-${var.env_name}"
  location            = azurerm_resource_group.apn_network_rg.location
  resource_group_name = azurerm_resource_group.apn_network_rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_subnet" "apn_subnet" {
  for_each             = local.subnets
  name                 = each.key
  resource_group_name  = azurerm_resource_group.apn_network_rg.name
  virtual_network_name = azurerm_virtual_network.apn_vnet.name
  address_prefixes     = each.value
}