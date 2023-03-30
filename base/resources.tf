resource "azurerm_resource_group" "apn_statefile" {
  name     = "apn-statefile"
  location = "Canada Central"
}

resource "azurerm_storage_account" "apn_statefile" {
  name                     = "mccrackenyycapnstatefile"
  resource_group_name      = azurerm_resource_group.apn_statefile.name
  location                 = azurerm_resource_group.apn_statefile.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "exampletag"
  }
}

resource "azurerm_storage_container" "apn_terraform" {
  name                  = "terraform"
  storage_account_name  = azurerm_storage_account.apn_statefile.name
  container_access_type = "private"
}