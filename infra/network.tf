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

  security_rule {
    name                       = "RDP-Allow"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "IP_HERE"
    #Add your public IP for testing access
    destination_address_prefix = "*"
  }
  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_virtual_network" "apn_vnet" {
  for_each            = local.networks
  name                = "apn-vnet-${each.key}-${var.env_name}"
  location            = azurerm_resource_group.apn_network_rg.location
  resource_group_name = azurerm_resource_group.apn_network_rg.name
  address_space       = each.value.vnet

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_subnet" "apn_subnet" {
  for_each             = local.networks
  name                 = each.key
  resource_group_name  = azurerm_resource_group.apn_network_rg.name
  virtual_network_name = azurerm_virtual_network.apn_vnet[each.key].name
  address_prefixes     = each.value.subnet
}

resource "azurerm_public_ip" "apn_public_ip" {
  name                = "apn-public-ip-${var.env_name}"
  resource_group_name = azurerm_resource_group.apn_network_rg.name
  location            = azurerm_resource_group.apn_network_rg.location
  allocation_method   = "Static"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_virtual_network_peering" "apn_peer_headoffice" {
  name                      = "apn-peer-headoffice-${var.env_name}"
  resource_group_name       = azurerm_resource_group.apn_network_rg.name
  virtual_network_name      = azurerm_virtual_network.apn_vnet["headoffice"].name
  remote_virtual_network_id = azurerm_virtual_network.apn_vnet["remoteoffice"].id
}

resource "azurerm_virtual_network_peering" "apn_peer_remoteoffice" {
  name                      = "apn-peer-remoteoffice-${var.env_name}"
  resource_group_name       = azurerm_resource_group.apn_network_rg.name
  virtual_network_name      = azurerm_virtual_network.apn_vnet["remoteoffice"].name
  remote_virtual_network_id = azurerm_virtual_network.apn_vnet["headoffice"].id
}