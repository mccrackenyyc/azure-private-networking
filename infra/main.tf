terraform {
  backend "azurerm" {
    subscription_id      = "20c17ce1-c880-4374-ab18-0c3a72158cf7"
    resource_group_name  = "apn-statefile"
    storage_account_name = "mccrackenyycapnstatefile"
    container_name       = "terraform"
    key                  = "apn.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.49.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}