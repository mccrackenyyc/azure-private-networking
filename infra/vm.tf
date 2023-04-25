resource "azurerm_resource_group" "apn_vm_rg" {
  name     = "apn-vm-rg-${var.env_name}"
  location = "Canada Central"

  tags = {
    tag = var.exampletag
  }
}

resource "azurerm_windows_virtual_machine" "apn_windows_ws" {
  name                = "apn-ws-01"
  resource_group_name = azurerm_resource_group.apn_vm_rg.name
  location            = azurerm_resource_group.apn_vm_rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.apn_nic_1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pro"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "apn_windows_svr" {
  name                = "apn-svr-01"
  resource_group_name = azurerm_resource_group.apn_vm_rg.name
  location            = azurerm_resource_group.apn_vm_rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.apn_nic_2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "apn_nic_1" {
  name                = "apn-nic-1"
  location            = azurerm_resource_group.apn_vm_rg.location
  resource_group_name = azurerm_resource_group.apn_vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.apn_subnet[element(keys(local.networks), 1)].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.apn_public_ip.id
  }
}

resource "azurerm_network_interface" "apn_nic_2" {
  name                = "apn-nic-2"
  location            = azurerm_resource_group.apn_vm_rg.location
  resource_group_name = azurerm_resource_group.apn_vm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.apn_subnet[element(keys(local.networks), 0)].id
    private_ip_address_allocation = "Dynamic"
  }
}