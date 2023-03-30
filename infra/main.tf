terraform {
  backend "azurerm" {
    subscription_id      = "00000000-0000-0000-0000-000000000000"
    resource_group_name  = "updatename-statefile"
    storage_account_name = "mccrackenyycupdatenamestatefile"
    container_name       = "terraform"
    key                  = "updatename.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.40.0"
      #hardcode to latest version available then remove this comment
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}