resource "azurerm_resource_group" "updatename_statefile" {
  name     = "updatename-statefile"
  location = "Canada Central"
}

resource "azurerm_storage_account" "updatename_statefile" {
  name                     = "mccrackenyycupdatenamestatefile"
  resource_group_name      = azurerm_resource_group.updatename_statefile.name
  location                 = azurerm_resource_group.updatename_statefile.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "exampletag"
  }
}

resource "azurerm_storage_container" "updatename_terraform" {
  name                  = "terraform"
  storage_account_name  = azurerm_storage_account.updatename_statefile.name
  container_access_type = "private"
}